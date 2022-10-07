import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_controller.dart';

class SwithDarkMode extends StatefulWidget {
  const SwithDarkMode({Key? key}) : super(key: key);

  @override
  State<SwithDarkMode> createState() => _SwithDarkModeState();
}

class _SwithDarkModeState extends State<SwithDarkMode> {
  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeController>(context, listen: false);
    return Switch(
        value: themeNotifier.isDarkMode,
        onChanged: (value) {
          themeNotifier.toggleTheme();
          setState(() {});
        });
  }
}
