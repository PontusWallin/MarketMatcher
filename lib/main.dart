import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:market_matcher/screens/wrapper.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  // This initialized Firebase, and makes sure that the Widgets are Intialized before that.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (context) => AuthService(),
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}


