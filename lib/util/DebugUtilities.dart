import 'package:market_matcher/util/shared_preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugUtilities {

  void printUserPrefs() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('-- Shared Preferences --');
    print(Preferences.UID + ': ' + prefs.getString(Preferences.UID));
    print(Preferences.USERNAME + ': ' + prefs.getString(Preferences.USERNAME));
    print(Preferences.EMAIL + ': ' + prefs.getString(Preferences.EMAIL));
    print('--------------------');
  }
}