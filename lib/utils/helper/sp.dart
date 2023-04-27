import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

addStringToSP(name, string) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(name, string);
}

addJsonToSP(name, Object object) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(name, jsonEncode(object));
}

Future<String?> getStringFromSP(name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? objStr = prefs.getString(name);
  return objStr;
}
