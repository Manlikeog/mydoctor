import 'package:flutter/material.dart';
import 'package:mydoctor/providers/doctor.dart';
import 'package:provider/provider.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Feature>(context);
    return Container(
      width: 90,
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.favorite,
                  size: 11,
                  color: product.color,
                ),
                const SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.star,
                  size: 11,
                  color: product.color2,
                ),
                Text(
                  product.rating,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Center(
            child: Image.asset(product.image),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            product.text1,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.attach_money,
                size: 15,
                color: Color(0xff0EBE7E),
              ),
              Text(
                product.text2,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xff677294),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );
  }
}
