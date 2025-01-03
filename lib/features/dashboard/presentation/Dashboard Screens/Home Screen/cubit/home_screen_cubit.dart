import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Home%20Screen/data/home_screen_transaction_model.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/main.dart';

part 'home_screen_state.dart';
part 'home_screen_cubit.freezed.dart';

@injectable
class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenState.initial());

  //get account balance details

  Future getAccountBalance() async {
    emit(LoadingState());

    HomeScreenTransactionModel homeScreenTransactionModel;

    double totalTransactionAmount = await getGeneralAmountFromDb(
      tableName: 'total_transaction',
      columnName: "total_amount",
    );

    double totalIncome = await getGeneralAmountFromDb(
      tableName: "total_income",
      columnName: "amount",
    );

    double totalExpense = await getGeneralAmountFromDb(
      tableName: "total_expense",
      columnName: "amount",
    );

    homeScreenTransactionModel = HomeScreenTransactionModel(
      balance: totalTransactionAmount,
      totalExpense: totalExpense,
      totalIncome: totalIncome,
    );

    emit(
      BalanceSuccessState(
        homeScreenTransactionModel: homeScreenTransactionModel,
      ),
    );
  }

  Future<double> getGeneralAmountFromDb({
    required String tableName,
    required String columnName,
  }) async {
    final table = supabase.from(tableName);
    double amount = 0;

    final String? userId = supabase.auth.currentUser?.id;

    final response = await table.select('*').eq('user_id', userId ?? "");

    // log("response = $response");

    //cast postgresList to List<Map<String ,dynamic>>
    List<Map<String, dynamic>> results = response.cast<Map<String, dynamic>>();

    if (results.isNotEmpty) {
      amount = results[0][columnName];
    }

    return amount;
  }

  void getAllTransactions({
    int? limit,
    int? month,
    int? year,
  }) async {
    year ??= DateTime.now().year;

    emit(LoadingState());

    try {
      final table = supabase.from("transaction");

      final String? userId = supabase.auth.currentUser?.id;

      var query = table.select('*').eq('user_id', userId ?? "");

      if (month != null && month != 0) {
        final startDate = DateTime(year, month, 1);
        final endDate = DateTime(year, month + 1, 1);

        query = query
            .gte('created_at', startDate.toIso8601String())
            .lt('created_at', endDate.toIso8601String());
      }

      final response = await (limit != null ? query.limit(limit) : query)
          .order('created_at', ascending: false);

      List<Map<String, dynamic>> results =
          response.cast<Map<String, dynamic>>();

      // log("all transaction results = $results");

      if (results.isNotEmpty) {
        List<TransactionModel> transactions = [];

        for (var transaction in results) {
          transactions.add(TransactionModel.fromJson(transaction));
        }

        emit(AllTransactionsSuccessState(transactions: transactions));
      } else {
        emit(ErrorState(errorMessage: "No transaction found"));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
