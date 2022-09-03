import 'package:budget_app/models/transaction.dart';
import 'package:budget_app/services/transaction_service.dart';
import 'package:budget_app/view_models/base_viewmodel.dart';

import '../locator.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class MainViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final TransactionService _transactionService = locator<TransactionService>();
  final LocalStorageService _storageService = locator<LocalStorageService>();
  User? _user;
  List<Transaction>? _todaysTransactions;

  setUser(User userData) {
    _user = userData;
    notifyListeners();
  }

  setToday(List<Transaction> transactions) {
    _todaysTransactions = transactions;
    notifyListeners();
  }

  User? get user => _user;

  List<Transaction>? get today => [...?_todaysTransactions];

  Future<bool> fetchProfile() async {
    String id = _storageService.currentUserId;
    final result = await _authService.getProfile(id);
    if (result != null) {
      setUser(result);
      return true;
    } else {
      return false;
    }
  }

  Future<List<Transaction>> fetchTodayTransactions() async {
    String id = _storageService.currentUserId;
    final result =
        await _transactionService.getDatedTransactions(DateTime.now(), id);

    setToday(result);
    return result;
  }
}
