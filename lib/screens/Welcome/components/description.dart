import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String text1;
  final String text2;
  const Description({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          text2,
          style: const TextStyle(
              color: Color(0xff677294), fontSize: 14, letterSpacing: 0.15),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
