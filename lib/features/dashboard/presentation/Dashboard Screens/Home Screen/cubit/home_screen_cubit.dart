import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Home%20Screen/data/home_screen_transaction_model.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/main.dart';

part 'home_screen_cubit.freezed.dart';
part 'home_screen_state.dart';

@injectable
class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenState.initial());

  //get account balance details

  Future<void> getAccountBalance() async {
    emit(LoadingState());

    final userId = supabase.auth.currentUser?.id ?? "";

    double totalTransactionAmount = 0.0;
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    // Listen to total_transaction table
    supabase
        .from('total_transaction')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .listen((List<Map<String, dynamic>> transactionData) {
          totalTransactionAmount = _getAmountFromData(
            transactionData,
            columnName: "total_amount",
          );
          _emitBalanceState(
            totalTransactionAmount,
            totalIncome,
            totalExpense,
          );
        });

    // Listen to total_income table
    supabase
        .from('total_income')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .listen((List<Map<String, dynamic>> incomeData) {
          totalIncome = _getAmountFromData(
            incomeData,
            columnName: "amount",
          );
          _emitBalanceState(
            totalTransactionAmount,
            totalIncome,
            totalExpense,
          );
        });

    // Listen to total_expense table
    supabase
        .from('total_expense')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .listen((List<Map<String, dynamic>> expenseData) {
          totalExpense = _getAmountFromData(
            expenseData,
            columnName: "amount",
          );
          _emitBalanceState(
            totalTransactionAmount,
            totalIncome,
            totalExpense,
          );
        });
  }

  void _emitBalanceState(
    double totalTransactionAmount,
    double totalIncome,
    double totalExpense,
  ) {
    final homeScreenTransactionModel = HomeScreenTransactionModel(
      balance: totalTransactionAmount,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
    );

    emit(
      BalanceSuccessState(
        homeScreenTransactionModel: homeScreenTransactionModel,
      ),
    );
  }

  double _getAmountFromData(
    List<Map<String, dynamic>> data, {
    required String columnName,
  }) {
    if (data.isNotEmpty) {
      return data[0][columnName] ?? 0.0;
    }
    return 0.0;
  }

  // void getAllTransactions({
  //   int? limit,
  //   int? month,
  //   int? year,
  // }) async {
  //   year ??= DateTime.now().year;

  //   emit(LoadingState());

  //   try {
  //     final table = supabase.from("transaction");

  //     final String? userId = supabase.auth.currentUser?.id;

  //     var query = table.select('*').eq('user_id', userId ?? "");

  //     if (month != null && month != 0) {
  //       final startDate = DateTime(year, month, 1);
  //       final endDate = DateTime(year, month + 1, 1);

  //       query = query
  //           .gte('created_at', startDate.toIso8601String())
  //           .lt('created_at', endDate.toIso8601String());
  //     }

  //     final response = await (limit != null ? query.limit(limit) : query)
  //         .order('created_at', ascending: false);

  //     List<Map<String, dynamic>> results =
  //         response.cast<Map<String, dynamic>>();

  //     // log("all transaction results = $results");

  //     if (results.isNotEmpty) {
  //       List<TransactionModel> transactions = [];

  //       for (var transaction in results) {
  //         transactions.add(TransactionModel.fromJson(transaction));
  //       }

  //       emit(AllTransactionsSuccessState(transactions: transactions));
  //     } else {
  //       emit(ErrorState(errorMessage: "No transaction found"));
  //     }
  //   } catch (e) {
  //     emit(ErrorState(errorMessage: e.toString()));
  //   }
  // }

  void getAllTransactions({
    int? limit,
    int? month,
    int? year,
  }) {
    emit(LoadingState());

    final String? userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      emit(ErrorState(errorMessage: "User not authenticated"));
      return;
    }

    year ??= DateTime.now().year;

    final table = supabase.from("transaction");
    var query = table
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    // Stream query will emit all changes, so filter the data after it's fetched
    query.listen((List<Map<String, dynamic>> data) {
      // Filter data by month and year if provided
      List<Map<String, dynamic>> filteredData = data.where((transaction) {
        final createdAt = DateTime.parse(transaction['created_at']);
        bool matchesMonthYear = true;

        if (month != null && month != 0) {
          matchesMonthYear = createdAt.month == month && createdAt.year == year;
        }

        return matchesMonthYear;
      }).toList();

      // Apply limit
      if (limit != null && filteredData.length > limit) {
        filteredData = filteredData.take(limit).toList();
      }

      if (filteredData.isNotEmpty) {
        List<TransactionModel> transactions = filteredData
            .map((transaction) => TransactionModel.fromJson(transaction))
            .toList();

        emit(AllTransactionsSuccessState(transactions: transactions));
      } else {
        emit(ErrorState(errorMessage: "No transaction found"));
      }
    }, onError: (error) {
      emit(ErrorState(errorMessage: error.toString()));
    });
  }
}
