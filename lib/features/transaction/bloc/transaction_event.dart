part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;
  final XFile? imageFile;

  AddTransaction({
    required this.transaction,
    this.imageFile,
  });
}
