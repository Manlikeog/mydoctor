// @dart = 2.9

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'Appointment/view_history.dart';
import 'Appointment/view_profile.dart';
import 'chat/chat_screen.dart';
import 'screens/home/home_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  User get user => FirebaseAuth.instance.currentUser;
  int pageIndex = 0;

  final page = [
    const HomeScreen(),
    const ViewHistory(),
    const ChatScreen(),
    ViewProfile()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: page[pageIndex],
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/blurgreen.png",
              width: size.width * 0.69,
              height: size.height * 0.39,
            ),
          ),
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: pageIndex == 0
                        ? const Color(0xff0EBE7E)
                        : Colors.transparent,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      color: pageIndex == 0
                          ? Colors.white
                          : const Color(0xff858EA9),
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: pageIndex == 1
                        ? const Color(0xff0EBE7E)
                        : Colors.transparent,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: pageIndex == 1
                          ? Colors.white
                          : const Color(0xff858EA9),
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: pageIndex == 2
                        ? const Color(0xff0EBE7E)
                        : Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                    child: Image.asset(
                      'assets/images/chat.png',
                      color: pageIndex == 2
                          ? Colors.white
                          : const Color(0xff858EA9),
                      height: 40,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: pageIndex == 3
                        ? const Color(0xff0EBE7E)
                        : Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        pageIndex = 3;
                      });
                    },
                    child: Image.asset(
                      'assets/images/record.png',
                      color: pageIndex == 3
                          ? Colors.white
                          : const Color(0xff858EA9),
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
