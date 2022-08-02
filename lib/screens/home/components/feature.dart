// @dart =2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/doctors.dart';
import 'feature_card.dart';

class Feature extends StatelessWidget {
  const Feature({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<FeatureDoctor>(context);
    final products = productData.featureItem;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: FeatureCard(),
            ),
          );
        },
      ),
    );
  }
}
