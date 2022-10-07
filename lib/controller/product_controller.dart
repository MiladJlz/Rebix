import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import '../model/product_model.dart';
import 'package:hive/hive.dart';

class ProductController extends ChangeNotifier {
  List<Product> _list = [];
  final String _boxName = "productBox";

  List<Product> get list => _list;

  Future<void> getProducts() async {
    var box = await Hive.openBox<Product>(_boxName);

    _list = box.values.toList();
    notifyListeners();
  }



  Future<void> add(String productName, String sellerName, String price,
      Uint8List imageUint8List) async {
    var box = await Hive.openBox<Product>(_boxName);

    await box.add(Product(productName, sellerName, price, imageUint8List));

    _list = box.values.toList();

    notifyListeners();
  }

  Future<int> getKey(int index) async {
    var box = await Hive.openBox<Product>(_boxName);
    return box.keyAt(index);
  }

  void deleteContact(key) async {
    var box = await Hive.openBox<Product>(_boxName);

    await box.delete(key);

    _list = box.values.toList();


    notifyListeners();
  }

  Future<void> editProduct(String productName, String sellerName, String price,
      Uint8List imageUint8List, int index) async {
    var box = await Hive.openBox<Product>(_boxName);
    var i = await getKey(index);

    await box.put(i, Product(productName, sellerName, price, imageUint8List));

    _list = box.values.toList();

    notifyListeners();
  }

  int get listLength => _list.length;
}
