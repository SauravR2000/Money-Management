part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;
  final XFile? imageFile;
  final File? pdfFile;

  AddTransaction({
    required this.transaction,
    this.imageFile,
    this.pdfFile,
  });
}
