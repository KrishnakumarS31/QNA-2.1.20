import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("password", password);
  }

  Future readCache(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var cache = preferences.getString("password");
    return cache;
  }

  Future removeCache(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("password");
  }
}
