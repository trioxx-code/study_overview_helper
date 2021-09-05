import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static const SP_DOZENTS = "Dozenten";
  static const SP_CLASSES = "Klassen";

  static void saveDataString(final String key, final String value) async {
    if (key.isEmpty) return;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  static void saveDataStringList(String key, List<String> value) async {
    if(key.isEmpty) return;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(key, value);
  }

  static Future<List<String>?> readDataStringList(String key) async {
    if(key.isEmpty) return null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key);
  }

  static Future<dynamic> readData(final String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }

  static Future<String?> readDataString(final String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}