import 'package:flutter/material.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/services/database.dart';
import 'package:market_matcher/util/Cache.dart';

class Profile extends StatefulWidget {

  final DatabaseService _database = DatabaseService();


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  AppUser cachedUser = Cache.user;
  String name = Cache.user.userName;
  String email = Cache.user.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: buildProfileAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          //key: _formKey,
          child: Column(
            children: [

              SizedBox(height: 20.0),
              buildNameTextFormField(),

              SizedBox(height: 20.0),
              buildEmailTextFormField(),

              // Register button
              RaisedButton(
                color: Colors.brown,
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {

                  Cache.user.userName = name;
                  Cache.user.email = email;
                  dynamic result = await widget._database.updateUserData(cachedUser.uid, cachedUser.userName, cachedUser.email);

                  // This part returns the result from server side validation.
                  if(result == null) {
                    setState(() {
                      //error = 'Something went wrong. Change your data or wait and try again.';
                      //loading = false;
                    });
                  }else {
                    Navigator.pop(
                      context,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildProfileAppBar() {
    return AppBar(
      title: Text('Profile'),
      backgroundColor: Colors.green,
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
              initialValue: cachedUser.email,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (val) => val.isEmpty ? 'Please enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            );
  }

  TextFormField buildNameTextFormField() {
    return TextFormField(
              initialValue: cachedUser.userName,
              decoration: InputDecoration(
                  fillColor: Colors.green[100],
                  filled: true,
                  labelText: 'Username',
              ),
              validator: (val) => val.isEmpty ? 'Please enter a username' : null,
              onChanged: (val) {
                setState(() => name = val);
              },
            );
  }
}
