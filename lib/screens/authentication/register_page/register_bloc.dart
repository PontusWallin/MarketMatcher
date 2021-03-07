import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_matcher/screens/authentication/register_page/register_model.dart';
import 'package:market_matcher/services/authentication.dart';

class RegisterBloc {
  final AuthService auth;
  final StreamController<RegisterModel> _modelController = StreamController<RegisterModel>();

  final formKey = GlobalKey<FormState>();

  RegisterBloc({this.auth});
  Stream<RegisterModel> get modelStream => _modelController.stream;
  RegisterModel _model = RegisterModel();
  void dispose() {
    _modelController.close();
  }

  void updateWith({
    String name,
    String email,
    String password,
    String error,
    bool isLoading,
    bool submitted
  }) {
    _model = _model.copyWith(
        name: name,
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
      await auth.registerWithEmailAndPassword(_model.name, _model.email, _model.password);
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}