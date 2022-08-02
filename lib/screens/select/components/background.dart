import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 800,
        ),
        Positioned(
          top: 0,
          left: 0,
          width: 290,
          height: 350,
          child: Image.asset(
            "assets/images/blurblue.png",
            width: 185,
            height: 250,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          width: 280,
          height: 290,
          child: Image.asset(
            "assets/images/blurgreen.png",
            width: 185,
            height: 250,
          ),
        ),
      ],
    );
  }
}
