import 'package:market_matcher/services/authentication.dart';
import 'AuthenticationFormType.dart';

class SignInState {

  final AuthService auth;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  EmailSignInFormType get formType => _formType;

  String _userEmail;

  String get userEmail => _userEmail;

  set userEmail(String value) {
    _userEmail = value;
  }

  String _userPassword;

  String get userPassword => _userPassword;

  set userPassword(String value) {
    _userPassword = value;
  }

  String _userName;

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  SignInState({this.auth});

  void toggleFormType() {
    _formType == EmailSignInFormType.signIn ? _formType = EmailSignInFormType.register
        : _formType = EmailSignInFormType.signIn;
  }

  Future<void> submit() async {
    try {
      await auth.signInWithEmailAndPassword(_userEmail, _userPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register() async {
    try {
      await auth.registerWithEmailAndPassword(_userName, _userEmail, _userPassword);
    } catch (e) {
      rethrow;
    }
  }
}