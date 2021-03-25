import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/util/Cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static final String UID = 'uid';
  static final String USERNAME = 'userName';
  static final String EMAIL = 'email';

  static Future<AppUser> loadAppUserFromPrefs() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return AppUser(
      uid: prefs.getString(Preferences.UID),
      userName: prefs.getString(Preferences.USERNAME),
      email: prefs.getString(Preferences.EMAIL),
    );
  }

  static void loadUserIntoPrefs(AppUser user) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Preferences.UID, user.uid);
    prefs.setString(Preferences.USERNAME, user.userName);
    prefs.setString(Preferences.EMAIL, user.email);

  }

  static void loadPrefsToCache() async {
    loadAppUserFromPrefs().then(
            (appUser) =>
            Cache.user = appUser
    );
  }
}