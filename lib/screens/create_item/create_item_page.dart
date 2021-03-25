import 'package:flutter/material.dart';
import 'package:market_matcher/util/AlertDialogBuilder.dart';
import 'package:market_matcher/util/SharedWidgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'create_item_state.dart';

class CreateItemPage extends StatefulWidget {

  static Widget create(BuildContext context) {
    return Scaffold(
      body: Injector(
        inject: [
          Inject<CreateItemState>(() => CreateItemState())
        ],
        builder: (context) => CreateItemPage(),
      ),
    );
  }

  @override
  _CreateItemsState createState() => _CreateItemsState();
}

class _CreateItemsState extends State<CreateItemPage> {

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
                onData: (_) => _returnToHomePage(),
                onError: (_) => _buildItemForm());
        },
      ),
        floatingActionButton: SharedWidgets().buildHomeFAB(context)
    );
  }

  Widget _returnToHomePage() {
    Navigator.pop(context);
    return _buildItemForm();
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