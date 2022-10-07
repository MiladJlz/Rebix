import "package:flutter/material.dart";

import '../../model/product_model.dart';

class CustomCardProduct extends StatelessWidget {
 final Product product;
 CustomCardProduct(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * .3,
      width: MediaQuery.of(context).size.width * .3,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      product.image,
                      fit: BoxFit.contain,
                      frameBuilder:
                      ((context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: frame != null
                              ? child
                              : SizedBox(
                            height: 60,
                            width: 60,
                            child:
                            CircularProgressIndicator(strokeWidth: 6),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                product.productName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                product.sellerName,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Text("\$ ${product.price}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
            ],
          ),
        ),
      ),
    );
  }
}
