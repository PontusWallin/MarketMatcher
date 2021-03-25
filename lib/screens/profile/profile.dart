import 'package:flutter/material.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/screens/profile/profile_state.dart';
import 'package:market_matcher/services/database.dart';
import 'package:market_matcher/util/SharedWidgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Profile extends StatefulWidget {

  final DatabaseService _database = DatabaseService();


  static Widget create(BuildContext context) {
    return Scaffold(
      body: Injector(
        inject: [
          Inject<ProfileState>(() => ProfileState())
        ],
        builder: (context) => Profile(),
      ),
    );
  }
  
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildProfileAppBar(),
      body: StateBuilder<ProfileState>(
        models: [Injector.getAsReactive<ProfileState>()],
          builder: (context, reactiveModel) {
            return reactiveModel.whenConnectionState(
                onIdle: () => buildIdle(),
                onWaiting: () => SharedWidgets().buildLoadingPage(),
                onData: (store) => buildContainer(context),
                onError: (error) => buildError(context, error));
          }),
    );
  }

  Widget buildIdle() {

    final reactiveModel = Injector.getAsReactive<ProfileState>();
    reactiveModel.setState(
          (store) => store.getProfile(),
    );

    return SharedWidgets().buildLoadingPage();
  }

  Widget buildError(BuildContext context, dynamic error) {
    return Center(
      child: Text('Error' + error.toString(), style: TextStyle(color: Colors.black))
    );
  }

  Widget buildContainer(BuildContext context)  {
    final reactiveModel = Injector.getAsReactive<ProfileState>();

    AppUser cachedUser = reactiveModel.state.cachedUser;

    return Container(
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
            ElevatedButton(
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {


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
    );
  }

  AppBar buildProfileAppBar() {
    return AppBar(
      title: Text('Profile'),
      backgroundColor: Colors.green,
    );
  }

  TextFormField buildEmailTextFormField() {
    final reactiveModel = Injector.getAsReactive<ProfileState>();
    AppUser cachedUser = reactiveModel.state.cachedUser;

    return TextFormField(
              initialValue: cachedUser.email,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (val) => val.isEmpty ? 'Please enter an email' : null,
              onChanged: (val) {
                setState(() => cachedUser.email = val);
              },
            );
  }

  TextFormField buildNameTextFormField() {
    final reactiveModel = Injector.getAsReactive<ProfileState>();
    AppUser cachedUser = reactiveModel.state.cachedUser;

    return TextFormField(
              initialValue: cachedUser.userName,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Username',
              ),
              validator: (val) => val.isEmpty ? 'Please enter a username' : null,
              onChanged: (val) {
                setState(() => cachedUser.userName = val);
              },
            );
  }
}
