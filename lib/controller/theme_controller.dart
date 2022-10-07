
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/theme_model.dart';

class ThemeController extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  late bool isDarkMode;

  ThemeController(this.sharedPreferences) {
    isDarkMode = sharedPreferences.getBool("isDarkMode") ?? false;

  }
  ThemeData getTheme() =>
      isDarkMode == false ? CustomTheme.lightTheme : CustomTheme.darkTheme;

 Future<void>  toggleTheme() async {

    isDarkMode = !isDarkMode;
    await sharedPreferences.setBool("isDarkMode", isDarkMode);
    notifyListeners();
  }



}
