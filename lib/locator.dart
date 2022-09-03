import 'package:budget_app/services/auth_service.dart';
import 'package:budget_app/services/local_storage_service.dart';
import 'package:budget_app/services/transaction_service.dart';
import 'package:budget_app/view_models/auth_viewmodel.dart';
import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);

  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<TransactionService>(TransactionService());

  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => MainViewModel());
}
