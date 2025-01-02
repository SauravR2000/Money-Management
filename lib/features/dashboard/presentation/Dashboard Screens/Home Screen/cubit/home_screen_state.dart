part of 'home_screen_cubit.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState.initial() = _Initial;

  const factory HomeScreenState.loading() = LoadingState;

  const factory HomeScreenState.balanceSuccess(
          {required HomeScreenTransactionModel homeScreenTransactionModel}) =
      BalanceSuccessState;

  const factory HomeScreenState.allTransactionsSuccess(
          {required List<TransactionModel> transactions}) =
      AllTransactionsSuccessState;

  const factory HomeScreenState.error({required String errorMessage}) =
      ErrorState;
}
