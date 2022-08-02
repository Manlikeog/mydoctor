import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text1;
  final VoidCallback press;
  const RoundedButton({
    Key? key,
    required this.text1,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: 270,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff0EBE7F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text1,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
