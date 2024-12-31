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
  BudgetBloc() : super(_Initial()) {
    on<BudgetEvent>((event, emit) {});
    on<DataLoadedEvent>(_onDataLoaded);
    on<PostDataEvent>(_onPostBudgetData);
  }

  final budgetList = <BudgetModel>[];

  void _onDataLoaded(DataLoadedEvent event, Emitter<BudgetState> emit) async {
    SecureLocalStorage secureLocalStorage = getIt<SecureLocalStorage>();
    final String userId =
        await secureLocalStorage.getStringValue(key: secureLocalStorage.userId);

    log("user id == $userId");

    if (userId.isNotEmpty) {
      final response =
          await supabase.from('Budget').select('*').eq('user_id', userId);

      log("response = $response");

      for (var budget in response) {
        final budgetModel = BudgetModel.fromJson(budget);
        budgetList.add(budgetModel);
      }

      log("budget list from bloc = $budgetList");

      emit(DataLoadedState(budgets: budgetList));
    } else {
      emit(ErrorState(message: "Error Occured"));
    }
  }

  void _onPostBudgetData(PostDataEvent event, Emitter<BudgetState> emit) async {
    SecureLocalStorage secureLocalStorage = getIt<SecureLocalStorage>();
    final String userId =
        await secureLocalStorage.getStringValue(key: secureLocalStorage.userId);

    
    
  }
}
