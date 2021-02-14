import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/util/Cache.dart';
import 'package:market_matcher/util/DebugUtilities.dart';
import 'package:market_matcher/util/shared_preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on User type returned from Firebase
  AppUser _appUserFromFirebaseUser(User user) {


    // Fetch the user data from the database, so we can store the users name in SharedPreferences.
    DatabaseService db = new DatabaseService();
    Stream<AppUser> appUserStream = db.userDatas;

    return user != null ? AppUser(uid: user.uid , userName: 'dummy name', email: 'email@email.com') : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges()
        .map(_appUserFromFirebaseUser);
  }
  
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;

      AppUser appUser = new AppUser(
          uid: user.uid,
          email: email,
          userName: 'name'
      );

      Preferences.loadUserIntoPrefs(appUser);
      Preferences.loadPrefsToCache();
      DebugUtilities().printUserPrefs();

      Cache.user = _appUserFromFirebaseUser(user);

      return Cache.user;

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;

      await DatabaseService(uid: user.uid).updateUserData(user.uid, name, email);

      AppUser appUser = new AppUser(
          uid: user.uid,
          email: email,
          userName: name
      );

      Preferences.loadUserIntoPrefs(appUser);
      Preferences.loadPrefsToCache();
      DebugUtilities().printUserPrefs();

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