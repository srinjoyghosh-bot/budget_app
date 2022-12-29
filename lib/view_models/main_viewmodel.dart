import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/models/transaction.dart';
import 'package:budget_app/models/transaction_history.dart';
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
  List<TransactionHistory>? _history;
  double _total = 0, _food = 0, _clothes = 0, _travel = 0, _miscellaneous = 0;
  double? totalSpent;
  int pageIndex = 0;

  DateTime _selectedDate = DateTime.now();
  String _budget = '0';

  clear() {
    _user = null;
    _todaysTransactions = null;
    _transactionsBody = null;
    _history = null;
    totalSpent = null;
    _budget = '0';
    _total = 0;
    _food = 0;
    _clothes = 0;
    _travel = 0;
    _miscellaneous = 0;
  }

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

  setPage(int index) {
    pageIndex = index;
    notifyListeners();
  }

  addTransaction(Transaction transaction) {
    if (_todaysTransactions == null) {
      _todaysTransactions = [transaction];
    } else {
      _todaysTransactions!.insert(0, transaction);
    }
    if (_monthlyTransactions == null) {
      _monthlyTransactions = [transaction];
    } else {
      _monthlyTransactions!.insert(0, transaction);
    }
    if (transaction.type == TransactionType.spent) {
      _total += transaction.amount;
    } else {
      _total -= transaction.amount;
    }

    switch (transaction.category) {
      case TransactionCategory.food:
        if (transaction.type == TransactionType.spent) {
          _food += transaction.amount;
        } else {
          _food -= transaction.amount;
        }
        break;
      case TransactionCategory.clothes:
        if (transaction.type == TransactionType.spent) {
          _clothes += transaction.amount;
        } else {
          _clothes -= transaction.amount;
        }
        break;
      case TransactionCategory.travel:
        if (transaction.type == TransactionType.spent) {
          _travel += transaction.amount;
        } else {
          _travel -= transaction.amount;
        }
        break;
      case TransactionCategory.miscellaneous:
        if (transaction.type == TransactionType.spent) {
          _miscellaneous += transaction.amount;
        } else {
          _miscellaneous -= transaction.amount;
        }
        break;
      default:
        if (transaction.type == TransactionType.spent) {
          _miscellaneous += transaction.amount;
        } else {
          _miscellaneous -= transaction.amount;
        }
        break;
    }
    notifyListeners();
  }

  User? get user => _user;

  String? get budget => _budget;

  List<Transaction>? get today => [...?_todaysTransactions];

  List<Transaction>? get body => [...?_transactionsBody];

  List<Transaction>? get monthly => [...?_monthlyTransactions];

  List<TransactionHistory>? get history => [...?_history];

  DateTime get selectedDate => _selectedDate;

  double get total => _total;

  double get food => _food;

  double get clothes => _clothes;

  double get travel => _travel;

  double get miscellaneous => _miscellaneous;

  int get index => pageIndex;

  Future<bool> fetchProfile() async {
    String token = _storageService.token;
    final result = await _authService.getProfile(token);
    if (result != null) {
      setUser(result);
      setBudget(result.budget);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editProfile(String username, String email) async {
    setState(ViewState.busy);
    String token = _storageService.token;
    final result = await _authService.editProfile(token, email, username);
    if (result['status'] == 200) {
      final user = User(
        id: _user!.id,
        name: username,
        email: email,
        password: _user!.password,
        budget: _budget,
      );
      setUser(user);
      setState(ViewState.idle);
      return true;
    }
    setErrorMessage(result['message']);
    setState(ViewState.idle);
    return false;
  }

  Future<List<Transaction>> fetchTodayTransactions() async {
    String token = _storageService.token;
    final result =
        await _transactionService.getDatedTransactions(DateTime.now(), token);

    setToday(result);
    return result;
  }

  Future<List<Transaction>> fetchBodyTransactions(DateTime date) async {
    setState(ViewState.busy);
    String token = _storageService.token;
    final result = await _transactionService.getDatedTransactions(date, token);
    setBody(result);
    setState(ViewState.idle);
    return result;
  }

  Future<bool> createTransaction(String title, String amount,
      TransactionType type, TransactionCategory category) async {
    setState(ViewState.busy);
    final result = await _transactionService.create(
        title, amount, type, category, _storageService.token);
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
        await _authService.changeBudget(_storageService.token, budget);
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
    String token = _storageService.token;
    final result = await _transactionService.getStats(token);
    if (result['status'] == 200) {
      final stats = result['stats'];
      totalSpent = stats.total;
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

  Future<bool> fetchHistory() async {
    String token = _storageService.token;
    final result = await _transactionService.history(token);
    if (result['status'] == 200) {
      _history = result['history'];
      return true;
    }
    return false;
  }
}
