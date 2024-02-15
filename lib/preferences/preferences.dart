import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _nom = "";
  static String _contrasenya = "";
  static bool _comprobar = false;

   static Future  init() async{

      _prefs = await SharedPreferences.getInstance();
    }

  static String get nom {
    return _prefs.getString("nom") ?? _nom;
  }

  static set nom(String value) {
    _nom = value;
    _prefs.setString("nom", value);
  }

  static String get contrasenya {
    return _prefs.getString("contrasenya") ?? _contrasenya;
  }

  static set contrasenya(String value) {
    _contrasenya = value;
    _prefs.setString("contrasenya", value);
  }

  static bool get comprobar {
    return _prefs.getBool("comprobar") ?? _comprobar;
  }

  static set comprobar(bool value) {
    _comprobar = value;
    _prefs.setBool("comprobar", value);
  }

  static void clearCredentials() {
    _prefs.remove("nom");
    _prefs.remove("contrasenya");
    _prefs.remove("comprobar");
  }
}
