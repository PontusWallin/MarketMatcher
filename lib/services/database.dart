import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/model/Item.dart';
import 'package:market_matcher/util/Cache.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final Query allItems = FirebaseFirestore.instance.collectionGroup('items');

  Future updateUserData(String id, String name, String email) async {
    return await userCollection
        .doc(uid)
        .set({
        'uid' : id,
        'name': name,
        'email' : email,
    });
  }

  // userDatas from snapshot
  AppUser _appUserFromSnapshot(DocumentSnapshot snapshot){
    return AppUser(
        uid: snapshot.data()['uid'],
        userName: snapshot.data()['name']
    );
  }

  void printDoc(QueryDocumentSnapshot doc) {
    print('description: ${doc.data()['description']}');
    print('location: ${doc.data()['location']}');
    print('name: ${doc.data()['name']}');
    print('price: ${doc.data()['price']}');
  }

  // items from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){

    List<QueryDocumentSnapshot> docs = snapshot.docs;

    return docs.map((doc) {

      double price = 99;
      if(doc.data()['price'] is int) {
        int p = doc.data()['price'];
        price = p.toDouble();
      } else {
        price = doc.data()['price'];
      }

      return Item(
          description: doc.data()['description'] ?? 'no description found',
          location: doc.data()['location'] ?? 'no location found',
          name: doc.data()['name'] ?? 'no name found',
          price: price ?? 0,
      );
    }).toList();
  }

  // get items doc stream
  Stream<List<Item>> get items {

    return allItems.snapshots()
        .map(_itemListFromSnapshot);
  }

  // get user doc stream
  Stream<AppUser> get userDatas {
    return userCollection.doc(uid).snapshots()
        .map(_appUserFromSnapshot);
  }

  // get single user
  AppUser getSingleUser(String uid) {

    return null;//.doc(uid).get();

  }

  // add item
  Future updateItemData(String name, String description, String price, String location, AppUser user) async {

    Map<String,Object> userMap = {
      'uid' : user.uid,
      'username' : user.userName
    };

    Map<String, Object> map = {
      'name' : name,
      'description' : description,
      'price' : double.parse(price),
      'location' : location,
      'author' : userMap
    };

    return await userCollection
        .doc(Cache.user.uid).collection('items').add(map);
  }
}