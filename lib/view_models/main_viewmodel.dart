import 'package:budget_app/constants/enums.dart';
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
  List<Transaction>? _transactionsBody;
  DateTime _selectedDate = DateTime.now();

  setUser(User userData) {
    _user = userData;
    notifyListeners();
  }

  setToday(List<Transaction> transactions) {
    _todaysTransactions = transactions;
    notifyListeners();
  }

  setBody(List<Transaction> transactions) {
    _transactionsBody = transactions;
    notifyListeners();
  }

  setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  User? get user => _user;

  List<Transaction>? get today => [...?_todaysTransactions];

  List<Transaction>? get body => [...?_transactionsBody];

  DateTime get selectedDate => _selectedDate;

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

  Future<List<Transaction>> fetchBodyTransactions(DateTime date) async {
    setState(ViewState.busy);
    String id = _storageService.currentUserId;
    final result = await _transactionService.getDatedTransactions(date, id);
    setBody(result);
    setState(ViewState.idle);
    return result;
  }
}
