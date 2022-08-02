import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  const Header({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              onPressed: (() => Navigator.pop(context)),
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 15,
              ),
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
