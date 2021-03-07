import 'dart:async';

class RegisterModel {

  RegisterModel({
    this.name = '',
    this.email = '',
    this.password = '',
    this.error = '',
    this.isLoading = true,
    this.submitted = false
  });

  final String name;
  final String email;
  final String password;
  final String error;
  final bool isLoading;
  final bool submitted;

  RegisterModel copyWith({
    String name,
    String email,
    String password,
    String error,
    bool isLoading,
    bool submitted
  }) {
    return RegisterModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted
    );
  }

}