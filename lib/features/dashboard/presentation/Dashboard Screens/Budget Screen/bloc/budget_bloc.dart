import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/cubit/budget_month_cubit.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/data/model/budget_model.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/main.dart';

part 'budget_bloc.freezed.dart';
part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(Initial()) {
    on<BudgetEvent>((event, emit) {});
    on<DataLoadedEvent>(_onDataLoaded);
    on<PostDataEvent>(_onPostBudgetData);
  }

  List<BudgetModel> budgetList = [];

  String getUserId() => supabase.auth.currentUser?.id ?? "";

  void _onDataLoaded(DataLoadedEvent event, Emitter<BudgetState> emit) async {
    emit(BudgetLoadingState());

    SecureLocalStorage secureLocalStorage = getIt<SecureLocalStorage>();
    final String userId =
        await secureLocalStorage.getStringValue(key: secureLocalStorage.userId);

    log("user id == $userId");

    if (userId.isNotEmpty) {
      final response = await supabase
          .from('budget')
          .select('*')
          .eq('user_id', userId)
          .eq('month', event.month);

      log("response for month =${event.month} = $response");

      budgetList = [];

      if (response.isNotEmpty) {
        for (var budget in response) {
          final budgetModel = BudgetModel.fromJson(budget);
          budgetList.add(budgetModel);
        }
      } else {
        budgetList = [];
      }
      log("budget list from bloc = $budgetList");

      // emit(Initial());
      emit(DataLoadedState(budgets: budgetList));
    } else {
      emit(ErrorState(message: "Error Occured"));
    }
  }

  void _onPostBudgetData(PostDataEvent event, Emitter<BudgetState> emit) async {
    SecureLocalStorage secureLocalStorage = getIt<SecureLocalStorage>();
    final String userId =
        await secureLocalStorage.getStringValue(key: secureLocalStorage.userId);

    log('user id == $userId');

    if (userId.isNotEmpty) {
      log('user id not empty');
      try {
        log('supabase call');
        final response = await supabase.from('budget').insert({
          'notification_status': event.notification,
          'month': event.month,
          'title': event.category,
          'amount': event.amount,
          'user_id': userId
        });

        log('response = $response');

        emit(PostDataState());
      } catch (e) {
        log('error = $e');
        emit(ErrorState(message: e.toString()));
      }
    }
  }
}
