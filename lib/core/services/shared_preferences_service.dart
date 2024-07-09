import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();
  static late final SharedPreferences _sp;

  static Future<void> init() async =>
      _sp = await SharedPreferences.getInstance();

  static setFirstTime() async {
    await _sp.setBool('firstTime', true);
  }

  static getFirstTime() {
    bool? data;
    data = _sp.getBool('firstTime');
    return data;
  }

  static setShowCase() async {
    await _sp.setBool('showcase', true);
  }

  static getShowCase() {
    return _sp.getBool('showcase');
  }

  static getTheme() {
    return _sp.getBool('theme');
  }

  static setTheme(bool value) {
    return _sp.setBool('theme', value);
  }

  static getLanguage() {
    return _sp.getString('language');
  }

  static setLanguage(String value) {
    return _sp.setString('language', value);
  }
}
