import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/services/database.dart';
import 'package:market_matcher/util/Cache.dart';

class Profile extends StatefulWidget {

  final DatabaseService _database = DatabaseService();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          //key: _formKey,
          child: Column(
            children: [

              // User Name text field
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.green[100],
                    filled: true,
                    labelText: 'Username'
                ),
                validator: (val) => val.isEmpty ? 'Please enter a username' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),

              // Email text field
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (val) => val.isEmpty ? 'Please enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),

              // Register button
              RaisedButton(
                color: Colors.brown,
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {

                  AppUser user = Cache.user;

                  // Creating some dummy data
                  user = AppUser(
                      uid: '111222333',
                      userName: name,
                      email: email);

                  dynamic result = await widget._database.updateUserData(user.uid, user.userName, user.email);

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
}
