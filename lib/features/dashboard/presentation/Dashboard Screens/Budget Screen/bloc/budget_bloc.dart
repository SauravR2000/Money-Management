import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
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
    on<DeleteMonthBudgetEvent>(_onDeleteMonthBudget);
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
      try {
        final stream = supabase
            .from('budget')
            .stream(primaryKey: ['id']).eq('user_id', userId);

        await for (var budgetData in stream) {
          // Filter the data locally by month
          final filteredData = budgetData.where((budget) {
            return budget['month'] == event.month;
          }).toList();

          budgetList = [];

          if (filteredData.isNotEmpty) {
            for (var budget in filteredData) {
              final budgetModel = BudgetModel.fromJson(budget);
              budgetList.add(budgetModel);
            }
          }

          emit(DataLoadedState(budgets: budgetList));

          log("response for month =${event.month} = $filteredData");
          log("budget list from bloc = $budgetList");
        }
      } catch (error) {
        emit(ErrorState(message: "An error occurred while loading data"));
        log("Error: $error");
      }
    } else {
      emit(Initial());
      emit(ErrorState(message: "User ID is empty"));
    }
  }

  void _onPostBudgetData(PostDataEvent event, Emitter<BudgetState> emit) async {
    final String userId = supabase.auth.currentUser?.id ?? "";

    log('user id == $userId');

    if (userId.isNotEmpty) {
      log('user id not empty');
      try {
        // Check if the category already exists for the month
        final existingBudget = await supabase
            .from('budget')
            .select('id')
            .eq('user_id', userId)
            .eq('title', event.category)
            .eq('month', event.month)
            .maybeSingle();

        if (existingBudget != null) {
          emit(ErrorState(
              message:
                  "Budget for this category already exists for the selected month."));
          return;
        }

        log("1");
        // Fetch total transaction
        final totalTransaction = await supabase
            .from('total_transaction')
            .select('total_amount')
            .eq('user_id', userId)
            .maybeSingle();

        log("amount = ${event.amount}");
        log("total transaction = ${totalTransaction?['total_amount']}");

        if (event.amount < (totalTransaction?['total_amount'] ?? 0)) {
          final response = await supabase.from('budget').insert({
            'notification_status': event.notification,
            'month': event.month,
            'title': event.category,
            'amount': event.amount,
            'user_id': userId,
          });

          log('response = $response');

          emit(PostDataState());
        } else {
          emit(ErrorState(message: "You don't have enough balance"));
        }
      } catch (e) {
        log('error = $e');
        emit(ErrorState(message: e.toString()));
      }
    } else {
      emit(ErrorState(message: "User ID is empty"));
    }
  }

  void _onDeleteMonthBudget(
      DeleteMonthBudgetEvent event, Emitter<BudgetState> emit) async {
    final String userId = supabase.auth.currentUser?.id ?? "";

    if (userId.isNotEmpty) {
      try {
        final response = await supabase
            .from('budget')
            .delete()
            .eq('user_id', userId)
            .eq('id', event.categoryId);

        log('delete response = $response');

        // Remove the deleted item from the budgetList
        budgetList = budgetList
            .where((budget) => budget.id != event.categoryId)
            .toList();

        log("Updated budget list from bloc = $budgetList");
        emit(DataLoadedState(budgets: budgetList));
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    } else {
      emit(ErrorState(message: "User ID is empty"));
    }
  }
}
