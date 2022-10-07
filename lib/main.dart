import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_rebix/controller/product_controller.dart';
import 'package:test_rebix/controller/theme_controller.dart';
import 'package:test_rebix/view/screens/main_screen.dart';

import 'model/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var config=await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductController(),
      ),
      ChangeNotifierProvider(create: (context) => ThemeController(config))
      ,
    ],
    child: EasyLocalization(

        supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
        path: 'assets/languages',
        fallbackLocale: const Locale('en', 'US'),
        saveLocale: true,
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, value, child) {
        return MaterialApp(
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          title: 'app_name'.tr(),
          theme: value.getTheme(),
          home: MainScreen(),
        );
      },
    );
  }
}
