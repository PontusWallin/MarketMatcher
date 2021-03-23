import 'package:flutter/material.dart';
import 'package:market_matcher/screens/create_item/CreateItemPage.dart';
import 'package:market_matcher/screens/profile/profile.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:market_matcher/services/database.dart';
import 'package:market_matcher/util/SharedWidgets.dart';
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

  int _selectedIndex = 0;

  void logout() async {
      await widget._auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: DatabaseService().items,
      child: Scaffold(
        appBar: SharedWidgets().buildAppBar(title: "Market Matcher", label: "Log out", icon: Icon(Icons.person), onPressed: logout),
        body: buildItemListContainer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline_sharp),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateItemsPage.create(context)),
            );
          },
        ),

        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.blue[500],
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[500],
        onTap: (index) {
          setState(() {

            _selectedIndex = index;

            if(_selectedIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            }
          });
        },
      );
  }

  Center buildItemListContainer() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ItemList()
        ],
        ),
      );
  }
}

