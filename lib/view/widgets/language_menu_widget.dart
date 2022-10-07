import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomButtonTest extends StatefulWidget {
  const CustomButtonTest({Key? key}) : super(key: key);

  @override
  State<CustomButtonTest> createState() => _CustomButtonTestState();
}

class _CustomButtonTestState extends State<CustomButtonTest> {



  @override
  Widget build(BuildContext context) {

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: context.locale.toString()=="en_US" ? MenuItems.us : MenuItems.ir,
        customItemsHeights: [
          ...List<double>.filled(MenuItems.firstItem.length, 48),
          8,
          ...List<double>.filled(MenuItems.secondItem.length, 48),
        ],
        items: [
          ...MenuItems.firstItem.map(
                (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          ...MenuItems.secondItem.map(
                (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),],
        onChanged: (value) {
          switch (value as MenuItem) {
            case MenuItems.us:
              setState(() {
              //  response = MenuItems.us;

                context.setLocale(const Locale('en', 'US'));

              });

              break;
            case MenuItems.ir:
              setState(() {
               // response = MenuItems.fa;
                context.setLocale(const Locale('fa', 'IR'));
              });

              break;
          }
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 100,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),

        ),
        dropdownElevation: 8,
        offset: const Offset(-10, 0),
      ),
    );
  }
}

class MenuItem {
  final String lan;
  final String flagPath;

  const MenuItem({
    required this.lan,
    required this.flagPath,
  });


}

class MenuItems {
  static const List<MenuItem> firstItem = [us];
  static const List<MenuItem> secondItem = [ir];



  static const us = MenuItem(lan: 'EN', flagPath: 'icons/flags/png/us.png');
  static const ir = MenuItem(lan: 'FA', flagPath: 'icons/flags/png/ir.png');


  static Widget buildItem(MenuItem item) {
    return Row(

      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(item.flagPath,
                package: 'country_icons',
                width: 25,
                height: 25,
              fit: BoxFit.contain,
               )),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.lan,
          style: const TextStyle(),
        ),
      ],
    );
  }
}
