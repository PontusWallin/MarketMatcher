import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_matcher/screens/home/home.dart';
import 'package:market_matcher/services/authentication.dart';
import 'package:market_matcher/services/database.dart';

class CreateItems extends StatefulWidget {

  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService();

  @override
  _CreateItemsState createState() => _CreateItemsState();
}

class _CreateItemsState extends State<CreateItems> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String description = '';
  String error = '';
  String price = '0';
  String location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('List a new Item'),
        elevation: 8.0,
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await widget._auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout')
          ),
        ], // these will appear as icons in the app bar!
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // Name text field
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Please enter an item name' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),

              // Description text field
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (val) {
                  setState(() => description = val);
                },
              ),

              // price text field
              SizedBox(height: 20.0),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // TODO verify that only numbers are typed here
                validator: (val) => val.isEmpty ? 'Please enter a price' : null,
                onChanged: (val) {
                  setState(() => price = val);
                },
              ),

              // Location text field
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (val) {
                  setState(() => location = val);
                },
              ),

              // Add Item button
              RaisedButton(
                color: Colors.brown,
                child: Text(
                  'Add Item',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);

                    Fluttertoast.showToast(msg: 'Uploading');
                    dynamic result = await widget._database.updateItemData(name, description, price, location);

                    // This part returns the result from server side validation.
                    if(result == null) {
                      setState(() {
                        error = 'Something went wrong, change your data or wait, and try again.';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
      ),
    );
  }
}
