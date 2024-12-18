import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/features/transaction/domain/repositories/transaction_repository.dart';
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
//upload image if selected
      if (event.imageFile != null) {
        final imageFile = event.imageFile!;
        final imageExtension = imageFile.path.split('.').last.toLowerCase();
        final imageBytes = await imageFile.readAsBytes();
        final userId = supabase.auth.currentUser!.id;
        final dateTime = DateTime.now().toString();
        String response =
            await supabase.storage.from('attachment').uploadBinary(
                  '/$userId/$dateTime',
                  imageBytes,
                  fileOptions: FileOptions(
                    upsert: true,
                    contentType: 'image/$imageExtension',
                  ),
                );

        attachmentId = response;

        log("upload file response = $response");
      }

      TransactionModel transaction = event.transaction;
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
}
