// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:mydoctor/screens/popular/components/popular_category.dart';
import 'package:provider/provider.dart';

import '../../../providers/doctors.dart';

class Ratings extends StatelessWidget {
  const Ratings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<PopularDoctor>(context);
    final products = productData.popularItem;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: const Text(
            "Ratings",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          itemCount: products.length,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, i) {
            return ChangeNotifierProvider.value(
              value: products[i],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: PopularCategory(
                  image: products[i].image,
                  title: products[i].text1,
                  description: products[i].text2,
                  ratings: products[i].ratings,
                  color1: products[i].color1,
                  color2: products[i].color2,
                  color3: products[i].color3,
                  color4: products[i].color4,
                  color5: products[i].color5,
                ),
              ),
            );
          },
          shrinkWrap: true,
        ),
      ],
    );
  }
}
