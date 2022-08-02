// @dart = 2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/doctor.dart';
import '../screens/occupation/occupation.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Occupation>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          OccupationScreen.routeName,
          arguments: product.work,
        );
      },
      child: Container(
        height: 30,
        width: 84,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: product.color),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(product.image),
      ),
    );
  }
}
