import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'database.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on User type returned from Firebase
  AppUser _appUserFromFirebaseUser(User user) {
    return user != null ? AppUser(/*uid: user.uid ,*/ userName: 'dummy name') : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges()
        .map(_appUserFromFirebaseUser);
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return _appUserFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;

      await DatabaseService(uid: user.uid).updateUserData('Dummy user name', 'dummy password');
      return _appUserFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e) {
      print(e.toString());
      return null;
    }
  }
}