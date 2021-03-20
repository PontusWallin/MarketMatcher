import 'package:flutter/material.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:market_matcher/util/AlertDialogBuilder.dart';
import 'package:market_matcher/util/SharedWidgets.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'AuthenticationFormType.dart';
import 'AuthenticationPageState.dart';

class AuthenticationPage extends StatefulWidget {

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Injector(
        inject: [
          Inject<SignInState>(() => SignInState(auth: auth))
        ],
        builder: (context) => AuthenticationPage(),
      ),
    );
  }

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedWidgets().buildAppBar("Toggle", new Icon(Icons.app_registration), toggleView),
      body: StateBuilder<SignInState>(
        models: [Injector.getAsReactive<SignInState>()],
        builder: (context, reactiveModel){
          return reactiveModel.whenConnectionState(
              onIdle: () => _buildForm(context),
              onWaiting: () => SharedWidgets().buildLoadingPage(),
              onData: (_) => _buildForm(context),
              onError: (error) => _buildForm(context)
          );
        },
      ),
    );
  }

  AppBar buildLoginPageAppBar(String label) {
    return AppBar(
      backgroundColor: Colors.blue,
      actions: [
        ElevatedButton.icon(
          onPressed: () {

          },
          icon: Icon(Icons.app_registration),
          label: Text(label),
        )
      ],
    );
  }

  Widget _buildForm(BuildContext context) {

    final reactiveModel = Injector.getAsReactive<SignInState>();
    return reactiveModel.state.formType == EmailSignInFormType.signIn ? _buildSignInForm(context) : _buildRegisterForm(context);
  }

  Widget _buildSignInForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SharedWidgets().sizedBox(),
            buildEmailTextFormField(),
            SharedWidgets().sizedBox(),
            buildPasswordTextFormField(),
            SharedWidgets().buildButton('Login', submit),
            SharedWidgets().sizedBox(),
            SharedWidgets().sizedBox(),
            Text("Don't have an account yet?"),
            SharedWidgets().buildButton(" Register one!", toggleView)
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildUserNameTextFormField(),
            SharedWidgets().sizedBox(),
            buildEmailTextFormField(),
            SharedWidgets().sizedBox(),
            buildPasswordTextFormField(),
            SharedWidgets().buildButton('Register', register),
            SharedWidgets().sizedBox(2),
            Text("Already have an account?"),
            SharedWidgets().buildButton("Log in instead!", toggleView)
          ],
        ),
      ),
    );
  }

  Widget buildUserNameTextFormField() {
    final reactiveModel = Injector.getAsReactive<SignInState>();

    return SharedWidgets().buildTextFormField(
        controller: _userNameController,
        label: 'Username',
        validator: (val) => val.isEmpty ? 'Please enter a username' : null,
        onChanged: (val) => reactiveModel.state.userName = val // We are setting the value without notifying the UI.
      // We're doing it like this so the Widget Tree isn't rebuilt every time the user types something in this field
    );
  }

  TextFormField buildEmailTextFormField() {
    final reactiveModel = Injector.getAsReactive<SignInState>();

    return SharedWidgets().buildTextFormField(
        controller: _emailController,
        label: 'E-mail',
        validator: (val) => val.isEmpty ? 'Please enter an email' : null,
        onChanged: (val) => reactiveModel.state.userEmail = val // We are setting the value without notifying the UI.
      // We're doing it like this so the Widget Tree isn't rebuilt every time the user types something in this field
    );
  }

  TextFormField buildPasswordTextFormField() {
    final reactiveModel = Injector.getAsReactive<SignInState>();

    return SharedWidgets().buildTextFormField(
        controller: _passwordController,
        obscureText: true,
        label: 'Password',
        validator: (val) => val.length < 10 ? 'Passwords must be 10+ characters long' : null,
        onChanged: (val) => reactiveModel.state.userPassword = val // We are setting the value without notifying the UI.
      // We're doing it like this so the Widget Tree isn't rebuilt every time the user types something in this field
    );
  }

  void register() async {
    final reactiveModel = Injector.getAsReactive<SignInState>();
    if (_formKey.currentState.validate()) {
      await reactiveModel.setState(
              (store) => store.register(),
          onError: (context, error) {
              AlertDialogBuilder.createErrorDialog(
                  title: "Error", exception: error, context: context);
            });
          }
    }

  void submit() async {
    final reactiveModel = Injector.getAsReactive<SignInState>();
    if (_formKey.currentState.validate()) {
      await reactiveModel.setState(
              (store) => store.submit(),
          onError: (context, error){
            AlertDialogBuilder.createErrorDialog(title: "Error", exception: error, context: context);
          }
      );
    }
  }

  void toggleView() {
    final reactiveModel = Injector.getAsReactive<SignInState>();
    reactiveModel.setState( (store) => store.toggleFormType());
  }
}