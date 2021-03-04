import 'package:flutter/material.dart';
import 'package:market_matcher/services/authentication.dart';

class Login extends StatefulWidget {

  final Function toggleView;

  const Login({Key key, this.toggleView}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
      appBar: buildLoginPageAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              SizedBox(height: 20.0),
              buildEmailTextFormField(),

              SizedBox(height: 20.0),
              buildPasswordTextFormField(),

              // Register button
              RaisedButton(
                color: Colors.brown,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);

                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);

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

  AppBar buildLoginPageAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      actions: [
        FlatButton.icon(
          onPressed: () {
            widget.toggleView();
          },
          icon: Icon(Icons.app_registration),
          label: Text('Registration'),
        )
      ],
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
}
