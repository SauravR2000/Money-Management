import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'transaction_listing_state.dart';
part 'transaction_listing_cubit.freezed.dart';

@injectable
class TransactionListingCubit extends Cubit<TransactionListingState> {
  TransactionListingCubit() : super(TransactionListingState.initial());

  int selectedMonthIndex = 0;

  void updateSelectedMonth({required int index}) {
    selectedMonthIndex = index;

    emit(ChangeMonthState(index: selectedMonthIndex));
  }
}
