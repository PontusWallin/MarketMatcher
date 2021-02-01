import 'package:flutter/material.dart';
import 'package:market_matcher/model/Item.dart';

class ItemTile extends StatelessWidget {

  final Item item;
  ItemTile(this.item);

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(
        title: Text(item.name),
        subtitle: Text(item.description),
      )
    );
  }
}
