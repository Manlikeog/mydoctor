import 'package:flutter/material.dart';

class Platform extends StatelessWidget {
  const Platform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 160,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/google.png"),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Google",
                  style: TextStyle(
                    color: Color(0xff677294),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: 160,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/facebook.png"),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Facebook",
                  style: TextStyle(
                    color: Color(0xff677294),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
