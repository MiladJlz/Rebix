import 'package:flutter/material.dart';
import 'shimmer_widget.dart';

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 256,
        crossAxisSpacing: 8,
        mainAxisSpacing:8,
      ),
      children: [
        shimmerEachItem(context), shimmerEachItem(context), shimmerEachItem(context), shimmerEachItem(context),

      ],
    );
  }

  Widget shimmerEachItem(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ShimmerWidget.rectangular(
                width: MediaQuery.of(context).size.width * .2,
                height: MediaQuery.of(context).size.height * .10),
          ),
          SizedBox(
            height: 18,
          ),
          ShimmerWidget.rectangular(
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .03),
          SizedBox(
            height: 6,
          ),
          ShimmerWidget.rectangular(
              width: MediaQuery.of(context).size.width * .1,
              height: MediaQuery.of(context).size.height * .03),
          SizedBox(
            height: 13,
          ),
          ShimmerWidget.rectangular(
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .03)
        ],
      ),
    );
  }
}
