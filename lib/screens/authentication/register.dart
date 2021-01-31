import 'package:flutter/material.dart';
import 'package:market_matcher/screens/authentication/user_credentials_form.dart';
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

              // Email text field
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Please enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),

              // Password text field
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 10 ? 'Passwords must be 10+ characters long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),

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

                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);

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

              // Text field for error from server side validation.
              SizedBox(height: 20.0),
              Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0)
              ),
            ],
          ),
        ),
      ),
    );
  }
}