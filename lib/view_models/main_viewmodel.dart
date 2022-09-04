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
  List<Transaction>? _monthlyTransactions;
  double _total = 0, _food = 0, _clothes = 0, _travel = 0, _miscellaneous = 0;

  DateTime _selectedDate = DateTime.now();
  String _budget = '0';

  setUser(User userData) {
    _user = userData;
    notifyListeners();
  }

  setBudget(String budget) {
    _budget = budget;
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

  addTransaction(Transaction transaction) {
    if (_todaysTransactions == null) {
      _todaysTransactions = [transaction];
    } else {
      _todaysTransactions!.add(transaction);
    }
    if (_monthlyTransactions == null) {
      _monthlyTransactions = [transaction];
    } else {
      _monthlyTransactions!.add(transaction);
    }
    _total += transaction.amount;
    switch (transaction.category) {
      case TransactionCategory.food:
        _food += transaction.amount;
        break;
      case TransactionCategory.clothes:
        _clothes += transaction.amount;
        break;
      case TransactionCategory.travel:
        _travel += transaction.amount;
        break;
      case TransactionCategory.miscellaneous:
        _miscellaneous += transaction.amount;
        break;
      default:
        _miscellaneous += transaction.amount;
        break;
    }
    notifyListeners();
  }

  User? get user => _user;

  String? get budget => _budget;

  List<Transaction>? get today => [...?_todaysTransactions];

  List<Transaction>? get body => [...?_transactionsBody];

  List<Transaction>? get monthly => [...?_monthlyTransactions];

  DateTime get selectedDate => _selectedDate;

  double get total => _total;

  double get food => _food;

  double get clothes => _clothes;

  double get travel => _travel;

  double get miscellaneous => _miscellaneous;

  Future<bool> fetchProfile() async {
    String id = _storageService.currentUserId;
    final result = await _authService.getProfile(id);
    if (result != null) {
      setUser(result);
      setBudget(result.budget);
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

  Future<bool> createTransaction(String title, String amount,
      TransactionType type, TransactionCategory category) async {
    setState(ViewState.busy);
    final result = await _transactionService.create(
        title, amount, type, category, _storageService.currentUserId);
    if (result['status'] == 200) {
      final transaction = result['transaction'];
      addTransaction(transaction);
      setState(ViewState.idle);
      return true;
    }
    setErrorMessage(result['message']);
    setState(ViewState.idle);
    return false;
  }

  Future<bool> updatedBudget(String budget) async {
    setState(ViewState.busy);
    final result =
        await _authService.changeBudget(_storageService.currentUserId, budget);
    if (result['status'] == 200) {
      setBudget(budget);
      setState(ViewState.idle);
      return true;
    }
    setState(ViewState.idle);
    setErrorMessage(result['message']);
    return false;
  }

  Future<bool> fetchStats() async {
    String id = _storageService.currentUserId;
    final result = await _transactionService.getStats(id);
    if (result['status'] == 200) {
      final stats = result['stats'];
      _total = stats.total;
      _food = stats.food;
      _clothes = stats.clothes;
      _travel = stats.travel;
      _miscellaneous = stats.miscellaneous;
      _monthlyTransactions = stats.transactions;
      return true;
    }

    return false;
  }
}
