import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_management_app/config/router/app_router.dart';
import 'package:money_management_app/config/theme/app_theme.dart';
import 'package:money_management_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:money_management_app/features/transaction/add_expense/presentation/add_expense_screen.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/Custom%20Floating%20Action%20Button/custom_floating_action_button.dart';
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
    return MaterialApp.router(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: myTheme,
    //   home: DashboardScreen(),
    // );
  }
}
