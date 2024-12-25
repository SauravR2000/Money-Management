import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_event.dart';
part 'budget_state.dart';
part 'budget_bloc.freezed.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(_Initial()) {
    on<BudgetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
