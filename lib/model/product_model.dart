import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  String productName;

  @HiveField(1)
  String sellerName;

  @HiveField(2)
  String price;

  @HiveField(3)
  Uint8List image;

  Product(this.productName, this.sellerName, this.price, this.image);
}
