import 'package:flutter/material.dart';

import '../../../widgets/header.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Header(text: "Find Doctors"),
        SizedBox(height: size.height * 0.03),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width * 0.9,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            cursorColor: Colors.black,
            autocorrect: false,
            onChanged: (value) {},
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_sharp,
              ),
              suffixIcon: const Icon(
                Icons.close_outlined,
              ),
              hintText: "Search",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
