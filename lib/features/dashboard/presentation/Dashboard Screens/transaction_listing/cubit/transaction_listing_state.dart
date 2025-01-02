part of 'transaction_listing_cubit.dart';

@freezed
class TransactionListingState with _$TransactionListingState {
  const factory TransactionListingState.initial() = _Initial;

  const factory TransactionListingState.changeMonth({required int index}) =
      ChangeMonthState;
}
