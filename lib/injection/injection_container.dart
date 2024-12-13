import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/injection/injection_container.config.dart';

/// An instance of [GetIt] used for dependency injection throughout the application.
final GetIt getIt = GetIt.instance;

/// Initializes the dependency injection container with all registered dependencies.
///
/// This method uses the [InjectableInit] annotation to automatically
/// configure and register dependencies in the [GetIt] instance.
@InjectableInit(initializerName: 'init')
Future<void> configureDependencies() async => getIt.init();
