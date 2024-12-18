part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final dynamic response;

  TransactionSuccess({required this.response});
}

class TransactionError extends TransactionState {
  final String errorMessage;

  TransactionError({required this.errorMessage});
}
