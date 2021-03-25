import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/util/shared_preferences/preferences.dart';

class Cache {

  static AppUser _user;

  static AppUser get user{
    return _user;
  }

  static set user(AppUser user) {
    _user = user;
  }

}