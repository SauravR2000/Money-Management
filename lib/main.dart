import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_management_app/config/router/app_router.dart';
import 'package:money_management_app/config/theme/app_theme.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize env
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANNON_KEY']!,
  );

  // Initialize GetIt for DI
  await configureDependencies();

  runApp(const MyApp());
}

final ThemeData myTheme = appTheme();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTransactions(supabase.auth.currentUser?.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      // home: TransactionDetailScreen(
      //   transactionModel: TransactionModel(
      //     userId: "2d90439c-4823-47ce-80e1-75d43afa9320",
      //     category: "Salary",
      //     description: "salary from december",
      //     wallet: "Esewa",
      //     attachment:
      //         "attachment/2d90439c-4823-47ce-80e1-75d43afa9320/2024-12-19 09:29:59.687964",
      //     isExpense: true,
      //     amount: 55.0,
      //     createdAt: DateTime.now(),
      //   ),
      // ),
      routerConfig: _appRouter.config(),
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: myTheme,
    //   home: BudgetScreenUi(),
    // );
  }

  void fetchTransactions(String userId) async {
    try {
      // Define the start and end of the month
      final startDate = DateTime(2024, 12, 1); // Start of January 2024
      final endDate =
          DateTime(2025, 1, 5); // Start of February 2024 (exclusive)

      // Query the table
      final response = await supabase
          .from('transaction') // Replace with your table name
          .select()
          .eq('user_id', userId) // Filter by user_id
          .gte('created_at',
              startDate.toIso8601String()) // Created at >= startDate
          .lt('created_at', endDate.toIso8601String()); // Created at < endDate

      log("filtered response = $response");

      // if (response.error != null) {
      //   throw Exception(response.error!.message);
      // }

      // Return the data
      // return List<Map<String, dynamic>>.from(response.data as List);
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }
}
