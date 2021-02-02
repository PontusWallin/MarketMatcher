import 'package:market_matcher/model/AppUser.dart';

class Cache {

  static AppUser _user;

  static AppUser get user => _user;

  static set user(AppUser user) {
    _user = user;
  }

}