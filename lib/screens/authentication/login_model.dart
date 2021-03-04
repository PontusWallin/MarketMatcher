import 'dart:async';

class LogInModel {

  LogInModel({
    this.email = '',
    this.password = '',
    this.error = '',
    this.isLoading = true,
    this.submitted = false
  });

  final String email;
  final String password;
  final String error;
  final bool isLoading;
  final bool submitted;

  LogInModel copyWith({
    String email,
    String password,
    String error,
    bool isLoading,
    bool submitted
  }) {
    return LogInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted
    );
  }

}