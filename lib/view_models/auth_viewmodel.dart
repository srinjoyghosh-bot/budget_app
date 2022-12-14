import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/models/user.dart';
import 'package:budget_app/view_models/base_viewmodel.dart';

import '../locator.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final LocalStorageService _storageService = locator<LocalStorageService>();
  User? _user;

  setUser(User userData) {
    _user = userData;
    notifyListeners();
  }

  User? get user => _user;

  Future<bool> signup(
      String email, String password, String username, String budget) async {
    setState(ViewState.busy);
    final result =
        await _authService.signupUser(email, password, username, budget);
    setState(ViewState.idle);
    if (!result['result']) {
      setErrorMessage(result['message']);
    }
    return result['result'];
  }

  Future<bool> login(String email, String password) async {
    setState(ViewState.busy);
    final result = await _authService.loginUser(email, password);
    setState(ViewState.idle);
    if (result['status'] == 200) {
      _storageService.isLoggedIn = true;
      _storageService.currentUserId = result['userId'];
      _storageService.token = result['token'];
      return true;
    }
    setErrorMessage(result['message']);
    return false;
  }

  void logout() {
    _storageService.isLoggedIn = false;
    _storageService.currentUserId = '';
    _storageService.token = '';
  }

  Future<bool> fetchProfile() async {
    String token = _storageService.token;
    final result = await _authService.getProfile(token);
    if (result != null) {
      setUser(result);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePassword(
      String oldPw, String newPw, String confirmPw) async {
    setState(ViewState.busy);
    final result = await _authService.changePassword(
        _storageService.token, oldPw, newPw, confirmPw);
    if (result['status'] == 200) {
      setState(ViewState.idle);
      return true;
    }
    setState(ViewState.idle);
    setErrorMessage(result['message']);
    return false;
  }
}
