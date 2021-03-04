import 'package:flutter/material.dart';
import 'package:market_matcher/screens/authentication/login_bloc.dart';
import 'package:market_matcher/screens/authentication/login_model.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:market_matcher/util/AlertDialogBuilder.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.toggleView, this.bloc}) : super(key: key);
  final LogInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Provider<LogInBloc>(
      create: (_) => LogInBloc(auth: auth),
      child: Consumer<LogInBloc>(
        builder: (_, bloc, __) => LoginPage(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  final Function toggleView;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = LogInBloc().formKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: buildLoginPageAppBar(),
      body: StreamBuilder<LogInModel>(
          stream: widget.bloc.modelStream,
          initialData: LogInModel(),
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
    );
  }

  Widget _buildContent(BuildContext context, LogInModel logInModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            buildEmailTextFormField(),

            SizedBox(height: 20.0),
            buildPasswordTextFormField(),

            // Login button
            RaisedButton(
                color: Colors.brown,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      await widget.bloc.submit(context);
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialogBuilder.createErrorDialog(title: "Sign in Error:", exception: e, context: context);
                          });
                    }
                  }
                }),
          ],
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

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (val) =>
          val.length < 10 ? 'Passwords must be 10+ characters long' : null,
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
}