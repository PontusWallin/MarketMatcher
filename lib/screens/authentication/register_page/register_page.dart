import 'package:flutter/material.dart';
import 'package:market_matcher/screens/authentication/register_page/register_bloc.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key key, this.toggleView, this.bloc}) : super(key: key);
  final RegisterBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Provider<RegisterBloc>(
      create: (_) => RegisterBloc(auth: auth),
      child: Consumer<RegisterBloc>(
        builder: (_, bloc, __) => RegisterPage(bloc: bloc, toggleView: () =>{}),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  final Function toggleView;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = RegisterBloc().formKey;

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
                    widget.bloc.submit(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (val) => val.length < 10 ? 'Passwords must be 10+ characters long' : null,
              onChanged: (val) {
                widget.bloc.updateWith(password: val);
              },
            );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (val) => val.isEmpty ? 'Please enter an email' : null,
              onChanged: (val) {
                widget.bloc.updateWith(email: val);
              },
            );
  }

  TextFormField buildUserNameTextFormField() {
    return TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              validator: (val) => val.isEmpty ? 'Please enter a username' : null,
              onChanged: (val) {
                widget.bloc.updateWith(name: val);
              },
            );
  }
}