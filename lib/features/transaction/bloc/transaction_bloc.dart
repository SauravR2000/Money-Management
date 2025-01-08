import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:money_management_app/helper/get_file_extension.dart';
import 'package:money_management_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;
  TransactionBloc(this._transactionRepository) : super(TransactionInitial()) {
    on<AddTransaction>(addTransaction);
  }

  void addTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    String attachmentId = "";

    try {
      bool hasImage = event.imageFile != null;
      bool hasPdf = event.pdfFile != null;
      final dateTime = DateTime.now().toIso8601String().replaceAll(':', '-');

      //upload image if selected
      if (hasImage) {
        final file = event.imageFile!;
        final fileExtension = getFileExtension(xfile: file);
        final imageBytes = await file.readAsBytes();
        final userId = supabase.auth.currentUser!.id;
        String response =
            await supabase.storage.from('attachment').uploadBinary(
                  '/$userId/$dateTime',
                  imageBytes,
                  fileOptions: FileOptions(
                    upsert: true,
                    contentType: 'image/$fileExtension',
                  ),
                );

        attachmentId = response;

        log("upload file response = $response");
      } else if (hasPdf) {
        final file = event.pdfFile!;
        final fileExtension = file.path.split('.').last.toLowerCase();
        final imageBytes = await file.readAsBytes();
        final userId = supabase.auth.currentUser!.id;

        String response =
            await supabase.storage.from('attachment').uploadBinary(
                  '/$userId/$dateTime.pdf',
                  imageBytes,
                  fileOptions: FileOptions(
                    upsert: true,
                    contentType: 'application/$fileExtension',
                  ),
                );

        attachmentId = response;
        log("pdf upload file response = $response");
      }

      TransactionModel transaction = event.transaction;

      String? budgetId =
          await getBudgetId(budgetTitle: event.transaction.category);

      transaction = transaction.copyWith(budgetId: budgetId);

      if (attachmentId.isNotEmpty) {
        transaction = transaction.copyWith(attachment: attachmentId);
      }

      log("after adding attachment = $transaction");

      var response = await _transactionRepository.storeTransaction(
        transaction: transaction,
      );

      log("add transaction response = $response");

      emit(TransactionSuccess(response: response));
    } catch (e) {
      log("error in add transaction = $e");

      emit(TransactionError(errorMessage: e.toString()));
    }
  }

  Future<String> getBudgetId({required String budgetTitle}) async {
    final response = await supabase
        .from('budget')
        .select('id')
        .eq('title', budgetTitle)
        .single();

    log("budget id = ${response['id']}");

    return response['id'];
  }
}
