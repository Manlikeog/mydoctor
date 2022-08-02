import 'package:flutter/material.dart';
import 'package:mydoctor/screens/home/components/background.dart';
import 'package:mydoctor/screens/home/components/feature.dart';
import 'package:mydoctor/screens/home/components/popular.dart';

import 'components/appbar.dart';
import 'components/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          const Background(),
          const HomeAppbar(),
          const Positioned(
            top: 190,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Positioned.fill(
            bottom: 520,
            top: 220,
            child: Categories(),
          ),
          Positioned(
            top: 340,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Popular Doctor",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 180,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "See all >",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff677294),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned.fill(
            top: 370,
            bottom: 200,
            child: Popular(),
          ),
        ],
      ),
    );
  }
}
