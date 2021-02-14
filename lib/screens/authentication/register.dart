import 'package:flutter/material.dart';
import 'package:market_matcher/services/authentication.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  const Register({Key key, this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.login),
            label: Text('Login'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              SizedBox(height: 20.0),
              buildUserNameTextFormField(),

              SizedBox(height: 20.0),
              buildEmailTextFormField(),

              SizedBox(height: 20.0),
              buildPasswordTextFormField(),

              // Register button
              RaisedButton(
                color: Colors.brown,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);

                    dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);

                    // This part returns the result from server side validation.
                    if(result == null) {
                      setState(() {
                        error = 'Please supply a valid email.';
                        loading = false;
                      });
                    }
                  }
                },
              ),

              SizedBox(height: 20.0),
              buildErrorTextArea(),
            ],
          ),
        ),
      ),
    );
  }

  Text buildErrorTextArea() {
    return Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)
            );
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (val) => val.length < 10 ? 'Passwords must be 10+ characters long' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
            );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (val) => val.isEmpty ? 'Please enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            );
  }

  TextFormField buildUserNameTextFormField() {
    return TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              validator: (val) => val.isEmpty ? 'Please enter a username' : null,
              onChanged: (val) {
                setState(() => name = val);
              },
            );
  }
}