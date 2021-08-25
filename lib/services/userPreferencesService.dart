import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  Future<bool> setUserLogin(bool isLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isUserLogin", isLogin);
    return prefs.commit();
  }

  Future<bool> isUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isUserLogin = prefs.getBool("isUserLogin");
    return isUserLogin;
  }

  Future<bool> setAccesstoken(String Accesstoken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Accesstoken", Accesstoken);
    return prefs.commit();
  }

  Future<String> getAccesstoken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String Accesstoken = prefs.getString("Accesstoken");
    return Accesstoken;
  }
}
