import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_matcher/screens/authentication/login_model.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:market_matcher/services/database.dart';
import 'package:provider/provider.dart';

class LogInBloc {
  final AuthService auth;
  final StreamController<LogInModel> _modelController = StreamController<LogInModel>();

  final formKey = GlobalKey<FormState>();

  LogInBloc({this.auth});
  Stream<LogInModel> get modelStream => _modelController.stream;
  LogInModel _model = LogInModel();
  void dispose() {
    _modelController.close();
  }

  void updateWith({
    String email,
    String password,
    String error,
    bool isLoading,
    bool submitted
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      error: error,
      isLoading: isLoading,
      submitted: submitted
    );
    _modelController.add(_model);
  }

  Future<void> submit(BuildContext context) async {
    updateWith(submitted: true, isLoading: true);

    try {
      await auth.signInWithEmailAndPassword(_model.email, _model.password);
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}