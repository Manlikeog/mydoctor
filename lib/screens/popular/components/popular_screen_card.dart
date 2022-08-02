import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/doctor.dart';

class PopularScreenCard extends StatelessWidget {
  const PopularScreenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Popular>(context);
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
              height: 188,
              width: 198,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            product.text1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            product.text2,
            style: const TextStyle(
              color: Color(0xa1677294),
              fontSize: 13,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: product.color1,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: product.color2,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: product.color3,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: product.color4,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: product.color5,
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
