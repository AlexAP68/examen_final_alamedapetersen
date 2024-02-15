import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

//Creamos las variables
  static String _nom = "";
  static String _contrasenya = "";

//Iniciamos preferences
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

//Geters y seters para las variables
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


//Limpiamos el preference
  static void clearCredentials() {
    _prefs.remove("nom");
    _prefs.remove("contrasenya");
  }
}
