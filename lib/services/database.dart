import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/model/Item.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final Query allItems = FirebaseFirestore.instance.collectionGroup('items');

  Future updateUserData(String name, String password) async {
    return await userCollection
        .doc(uid)
        .set({
        'name': name,
    });
  }

  // userDatas from snapshot
  AppUser _appUserFromSnapshot(DocumentSnapshot snapshot){
    return AppUser(
        userName: snapshot.data()['name']
    );
  }

  // items from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){

    List<QueryDocumentSnapshot> docs = snapshot.docs;

    return docs.map((doc) {
      return Item(
          description: doc.data()['description'] ?? 'no description found',
          location: doc.data()['location'] ?? 'no location found',
          name: doc.data()['name'] ?? 'no name found',
          price: doc.data()['price'] ?? 0,
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
}