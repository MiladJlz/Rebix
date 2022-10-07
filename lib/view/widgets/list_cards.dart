import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_rebix/controller/product_controller.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:test_rebix/model/product_model.dart';

import '../../controller/theme_controller.dart';
import '../screens/add_or_update_product.dart';
import 'custom_card_product.dart';

class ListCards extends StatelessWidget {
  const ListCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer2<ProductController,ThemeController>(
      builder: ((context, value,themeValue, child) {

        var productList =value.list;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 256,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return FocusedMenuHolder(
                  menuWidth: MediaQuery.of(context).size.width * 0.40,
                  blurSize: 5.0,
                  menuItemExtent: 45,
                  menuBoxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  duration: Duration(milliseconds: 100),
                  animateMenuItems: true,
                  blurBackgroundColor: Colors.black54,
                  openWithTap: true,
                  menuOffset: 10.0,
                  bottomOffsetHeight: 80.0,
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(
                        title: Text(
                          'edit_button'.tr(),
                          style: TextStyle(
                              color:
                              themeValue.getTheme().textTheme.bodyText1?.color),
                        ),
                        trailingIcon: Icon(
                          Icons.edit,
                          color: themeValue.getTheme().textTheme.bodyText1?.color,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddOrUpdateProduct(
                                  productList[index].productName,
                                  productList[index].sellerName,
                                  productList[index].price,
                                  productList[index].image,
                                  index)));
                        },backgroundColor: themeValue.getTheme().scaffoldBackgroundColor),
                    FocusedMenuItem(
                        title: Text(
                          'delete_button'.tr(),
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        trailingIcon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () async {
                          value.deleteContact(await value.getKey(index));
                        },backgroundColor: themeValue.getTheme().scaffoldBackgroundColor),
                  ],
                  onPressed: () {},
                  child: CustomCardProduct(productList[index]));
            },
          ),
        );
      }),
    );
  }


}
