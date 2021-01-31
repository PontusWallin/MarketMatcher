import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:market_matcher/model/Item.dart';

class ItemText extends StatefulWidget {
  @override
  _ItemTextState createState() => _ItemTextState();
}

class _ItemTextState extends State<ItemText> {
  @override
  Widget build(BuildContext context) {

    List<Item> items = Provider.of<List<Item>>(context) ?? [];

    String itemText;

    if(items.isEmpty || items == null || items.first == null) {
      itemText = 'Empty';
    } else {
      Item firstItem = items.first;
      itemText = firstItem.name;
    }

    return Text(
        itemText,
    );
  }
}