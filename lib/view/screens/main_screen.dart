import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_rebix/view/screens/add_or_update_product.dart';
import 'package:test_rebix/view/screens/settings_screen.dart';
import 'package:test_rebix/view/shimmer/shimmer_screen.dart';
import 'package:test_rebix/view/widgets/list_cards.dart';

import '../../controller/product_controller.dart';
import 'package:easy_localization/easy_localization.dart';
class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;


  _asyncMethod() async {

     await Provider.of<ProductController>(context,listen: false).getProducts();
    setState(()  {
      isLoading = false;
    });
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddOrUpdateProduct()));
      }),
      appBar: AppBar(title: Text('app_name'.tr()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: Container(child: isLoading == true ? ShimmerScreen() : ListCards()


          ),
    );
  }
}
