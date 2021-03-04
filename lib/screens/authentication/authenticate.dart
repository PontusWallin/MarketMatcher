import 'package:flutter/material.dart';
import 'package:market_matcher/screens/authentication/login_old.dart';
import 'package:market_matcher/screens/authentication/login_page_w_bloc.dart';
import 'package:market_matcher/screens/authentication/register.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIn) {
      return LoginPage.create(context);
    } else {
      return LoginPage.create(context);
    }
  }
}
