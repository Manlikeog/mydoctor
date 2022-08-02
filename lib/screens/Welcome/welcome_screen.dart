// @dart = 2.9

import 'package:flutter/material.dart';

import 'components/onboard.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            child: Image.asset(
              "assets/images/Greencircle.png",
              width: size.width * 0.56,
              height: size.height * 0.35,
            ),
          ),
          const Onboard(),
          Positioned(
            right: 0,
            bottom: -29,
            child: Image.asset(
              "assets/images/blurgreen.png",
              width: size.width * 0.69,
              height: size.height * 0.39,
            ),
          ),
        ],
      ),
    );
  }
}
