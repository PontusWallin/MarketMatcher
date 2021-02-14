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

        leading: buildImageAvatar(),
        title: buildPriceText(),
        subtitle: buildNameText(),

        trailing: Icon(Icons.keyboard_arrow_right),

        onTap: (){
          goToSingleItemScreen();
        },
      )
    );
  }

  void goToSingleItemScreen() {
    Fluttertoast.showToast(
        msg: "Go to a single add screen",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Text buildNameText() {
    return Text(
          item.name,
          textScaleFactor: 1.33
      );
  }

  Text buildPriceText() {
    return Text(
        '${item.price}€',
        textScaleFactor: 1.5
      );
  }

  CircleAvatar buildImageAvatar() {
    return CircleAvatar(
        backgroundColor: Colors.yellow,
        backgroundImage: AssetImage('assets/exchange.png'),
      );
  }
}
