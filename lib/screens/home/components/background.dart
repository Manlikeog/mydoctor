import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 850,
        ),
        Positioned(
          top: 150,
          left: 0,
          child: Image.asset(
            "assets/images/blurblue.png",
            width: size.width * 0.69,
            height: size.height * 0.39,
          ),
        ),
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
    );
  }
}
