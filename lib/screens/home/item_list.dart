import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_matcher/model/Item.dart';
import 'package:provider/provider.dart';

import 'Item_tile.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {

    final List<Item> items = Provider.of<List<Item>>(context) ?? [];

    return Expanded(
      child: ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          return ItemTile(items[index]);
        },
      ),
    );
  }
}