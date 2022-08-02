// @dart = 2.9

import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

import '../Signup/login_screen.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  bool _isLoading = false;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OnBoard(
      imageWidth: size.width * 0.87,
      titleStyles: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.15,
      ),
      descriptionStyles: const TextStyle(
        fontSize: 13,
        color: Color(0xff677294),
      ),
      pageIndicatorStyle: const PageIndicatorStyle(
        width: 100,
        inactiveColor: Color(0xaf0EBE7F),
        activeColor: Color(0xff0EBE7F),
        inactiveSize: Size(8, 8),
        activeSize: Size(12, 12),
      ),
      skipButton: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ),
          );
        },
        child: const Text(
          "Skip",
          style: TextStyle(
            color: Color(0xff677294),
          ),
        ),
      ),
      onBoardData: onBoardData,
      pageController: _pageController,
      nextButton: OnBoardConsumer(
        builder: (context, ref, child) {
          final state = ref.watch(onBoardStateProvider);
          return InkWell(
            onTap: () {
              setState(() {
                _isLoading = true;
              });

              Future.delayed(
                const Duration(seconds: 1),
                () {
                  setState(() {
                    _isLoading = false;
                  });

                  _onNextTap(state, context);
                },
              );
            },
            child: Container(
              width: 230,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xff0EBE7F),
                borderRadius: BorderRadius.circular(30),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Color(0xff0EBE7F),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      state.isLastPage ? "Done" : "Get Started",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState, BuildContext context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOutSine,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Find Trusted Doctors",
    description: """Contrary to popular belief, Lorem Ipsum is not
      simply random text. It has roots in a 
      piece of it over 2000 years old.""",
    imgUrl: "assets/images/doctor1.png",
  ),
  const OnBoardModel(
    title: "Choose Best Doctors",
    description: """Contrary to popular belief, Lorem Ipsum is not
      simply random text. It has roots in a 
      piece of it over 2000 years old.""",
    imgUrl: 'assets/images/doctor2.png',
  ),
  const OnBoardModel(
    title: "Easy Appointments",
    description: """Contrary to popular belief, Lorem Ipsum is not
      simply random text. It has roots in a 
      piece of it over 2000 years old.""",
    imgUrl: 'assets/images/doctor3.png',
  ),
];
