import 'package:flutter/material.dart';

class Slots extends StatelessWidget {
  final String text;
  const Slots({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      child: Container(
        width: 70,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(14, 190, 127, 0.2).withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xff0EBE7F),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
