import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:market_matcher/services/database.dart';
import 'package:market_matcher/util/AlertDialogBuilder.dart';
import 'package:market_matcher/util/Cache.dart';
import 'package:market_matcher/util/SharedWidgets.dart';
import 'package:market_matcher/util/shared_preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'CreateItemState.dart';

class CreateItemsPage extends StatefulWidget {

  static Widget create(BuildContext context) {
    return Scaffold(
      body: Injector(
        inject: [
          Inject<CreateItemState>(() => CreateItemState())
        ],
        builder: (context) => CreateItemsPage(),
      ),
    );
  }

  @override
  _CreateItemsState createState() => _CreateItemsState();
}

class _CreateItemsState extends State<CreateItemsPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: SharedWidgets().buildAppBar(title: 'Create a listing'),
        body: StateBuilder<CreateItemState> (
        models: [Injector.getAsReactive<CreateItemState>()],
        builder: (context, reactiveModel){
            return reactiveModel.whenConnectionState(
                onIdle: () => _buildItemForm(),
                onWaiting: () => SharedWidgets().buildLoadingPage(),
                onData: (data) => _buildItemForm(), // Add an "Item Created" - feedback screen thingy?
                onError: (_) => _buildItemForm());
        },
      ),
        floatingActionButton: SharedWidgets().buildHomeFAB(context)
    );
  }

  Widget _buildItemForm() {

    final reactiveModel = Injector.getAsReactive<CreateItemState>();

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SharedWidgets().sizedBox(),
            SharedWidgets().buildTextFormField(
              label: 'Name',
              validator: (val) => val.isEmpty ? 'Please enter an item name' : null,
              onChanged: (val) => reactiveModel.state.name = val,
            ),

            SharedWidgets().sizedBox(),
            SharedWidgets().buildTextFormField(
              label: 'Description',
              onChanged: (val) => reactiveModel.state.description = val,
            ),

            SharedWidgets().sizedBox(),
            SharedWidgets().buildNumberFormField(
              label: 'Price',
              validator: (val) => val.isEmpty ? 'Please enter a price' : null,
              onChanged: (val) => reactiveModel.state.price = val,
            ),

            SharedWidgets().sizedBox(),
            SharedWidgets().buildTextFormField(
              label: 'Location',
              onChanged: (val) => reactiveModel.state.location = val,
            ),

            SharedWidgets().sizedBox(),
            SharedWidgets().buildButton(
                label: 'Add Item',
                onPressed: submit
            ),
          ],
        ),
      ),
    );
  }

  void submit() async {
    final reactiveModel = Injector.getAsReactive<CreateItemState>();
    await reactiveModel.setState(
            (store) => store.submit(),
        onError: (context, error) {
          AlertDialogBuilder.createErrorDialog(
              title: "Error", exception: error, context: context);
        });
  }
}