import 'package:flutter/material.dart';
import 'file:///C:/Users/Pontus/StudioProjects/market_matcher/lib/screens/authentication/login_page/login_page.dart';
import 'package:market_matcher/screens/authentication/register_page/register_page.dart';

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
      return RegisterPage.create(context);
    }
  }
}
