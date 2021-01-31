import 'package:flutter/material.dart';
import 'package:market_matcher/services/authentication.dart';

class UserCredentialsForm extends StatefulWidget {

  final String appBarText;
  final String action;
  final IconData icon;

  final Function toggleView;

  UserCredentialsForm({
    Key key,
    @required this.toggleView,
    @required this.appBarText,
    @required this.action,
    @required this.icon,
  }) : super(key : key);

  @override
  _UserCredentialsFormState createState() => _UserCredentialsFormState();
}

class _UserCredentialsFormState extends State<UserCredentialsForm> {

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
            icon: Icon(widget.icon),
            label: Text('${widget.appBarText}'),
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
                  '${widget.action}',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    //TODO: implement Authorizations class

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
