import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_management_app/config/router/app_router.dart';
import 'package:money_management_app/config/theme/app_theme.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/budget_screen.dart';
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
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   theme: myTheme,
    //   debugShowCheckedModeBanner: false,
    //   theme: myTheme,
    //   home: TransactionDetailScreen(
    //     transactionModel: TransactionModel(
    //       userId: "2d90439c-4823-47ce-80e1-75d43afa9320",
    //       category: "Salary",
    //       description: "salary from december",
    //       wallet: "Esewa",
    //       attachment:
    //           "attachment/2d90439c-4823-47ce-80e1-75d43afa9320/2024-12-19 09:29:59.687964",
    //       isExpense: true,
    //       amount: 55.0,
    //       createdAt: DateTime.now(),
    //     ),
    //   ),
    // );
    //   routerConfig: _appRouter.config(),
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: BudgetScreen(),
    );
  }
}
