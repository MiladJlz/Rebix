import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../widgets/language_menu_widget.dart';
import '../widgets/location_widget.dart';
import '../widgets/switch_dark_mode.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('settings_title'.tr() ),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'theme_title'.tr(),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('light_theme_setting'.tr(), style: TextStyle()),
                    SwithDarkMode(),
                    Text('dark_theme_setting'.tr(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                  ],
                ),
                Divider(color: Theme.of(context).textTheme.bodyText1?.color),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'language_setting'.tr(),
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CustomButtonTest(),
                    )
                  ],
                ),
                Divider(color: Theme.of(context).textTheme.bodyText1?.color),
              ],
            ),
            const LocationWidget(),

            FutureBuilder(
                future: getInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Future<String> getInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return 'Running on ${webBrowserInfo.userAgent}';
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return 'Running on Android ${androidInfo.version.release} , ${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return 'Running on ${iosInfo.utsname.machine}';
    } else {
      return "";
    }

    // e.g. "Moto G (4)"
  }


}
