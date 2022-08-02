import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Welcome/Signup/login_screen.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  User? get user => FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          width: size.width * 1,
          height: 160,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff0EBE7E), Color(0xdf07D9AD)]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Hi ${user!.displayName}",
                      style: const TextStyle(
                          color: Color(0xfffafafa),
                          fontSize: 19,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Find Your Doctor",
                      style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Color(0xffffffff),
                    size: 25,
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 125,
          left: 20,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
        ),
        Container(
          height: 180,
        )
      ],
    );
  }
}
