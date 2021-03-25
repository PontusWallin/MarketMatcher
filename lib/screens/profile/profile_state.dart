import 'package:market_matcher/model/AppUser.dart';
import 'package:market_matcher/util/shared_preferences/preferences.dart';

class ProfileState {

  AppUser _cachedUser;

  AppUser get cachedUser => _cachedUser;

  set cachedUser(AppUser value) {
    _cachedUser = value;
  }

  ProfileState();

  void getProfile() async {
    _cachedUser = await Preferences.loadAppUserFromPrefs();
  }

}