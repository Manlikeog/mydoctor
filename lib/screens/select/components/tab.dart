import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final String text;
  final Color color1;
  final Color color2;
  final Color color3;
  const Tabs({
    Key? key,
    required this.text,
    required this.color1,
    required this.color2,
    required this.color3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color1,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "9 slots available",
            style: TextStyle(fontSize: 10, color: color2),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0x3a677294),
        ),
        borderRadius: BorderRadius.circular(5),
        color: color3,
      ),
    );
  }
}
