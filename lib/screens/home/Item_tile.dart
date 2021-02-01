import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_matcher/model/Item.dart';

class ItemTile extends StatelessWidget {

  final Item item;
  ItemTile(this.item);

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor: Colors.yellow,
          backgroundImage: AssetImage('assets/exchange.png'),
        ),

        title: Text(
          '${item.price}€',
          textScaleFactor: 1.5
        ),
        subtitle: Text(
            item.name,
            textScaleFactor: 1.33
        ),

        trailing: Icon(Icons.keyboard_arrow_right),

        onTap: (){
          Fluttertoast.showToast(
              msg: "Go to a single add screen",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
      )
    );
  }
}
