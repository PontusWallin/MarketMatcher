import 'package:flutter/material.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/screens/authentication/authenticate.dart';
import 'package:market_matcher/screens/authentication/login_page_w_bloc.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<AppUser>(
      stream: auth.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final AppUser user = snapshot.data;
          if (user == null) {
            return LoginPage.create(context);
          }
          return Home();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}