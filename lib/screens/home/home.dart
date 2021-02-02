import 'package:flutter/material.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:market_matcher/services/database.dart';
import 'package:provider/provider.dart';
import 'package:market_matcher/model/Item.dart';

import 'item_list.dart';

class Home extends StatefulWidget {

  final AuthService _auth = AuthService();

  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: DatabaseService().items,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Market Matcher'),
          elevation: 8.0,
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  await widget._auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('logout')
            ),
          ], // these will appear as icons in the app bar!
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ItemList()
          ],
          ),
        ),
      ),
    );
  }
}