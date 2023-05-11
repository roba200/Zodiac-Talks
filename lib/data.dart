import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static SharedPreferences? preferences;

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static Future set(String value) async =>
      await preferences!.setString('logo', value);

  static String? get() => preferences!.getString('logo');
}
