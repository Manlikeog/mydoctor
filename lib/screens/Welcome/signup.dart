// @dart = 2.9

import 'package:flutter/material.dart';
import 'package:mydoctor/screens/Welcome/patient_signup.dart';

import 'doctor_signup.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/blurblue.png",
              width: size.width * 0.69,
              height: size.height * 0.39,
            ),
          ),
          Positioned(
            right: 0,
            bottom: -29,
            child: Image.asset(
              "assets/images/blurgreen.png",
              width: size.width * 0.69,
              height: size.height * 0.39,
            ),
          ),
          Positioned.fill(
            top: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xff0EBE7F),
                      child: IconButton(
                        padding: EdgeInsets.only(right: 53, bottom: 60),
                        icon: const Icon(
                          Icons.person_sharp,
                          color: Colors.white,
                          size: 80,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const PatientSignupScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    const Text(
                      'PATIENT',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xff0EBE7F),
                      child: IconButton(
                        padding: EdgeInsets.only(right: 53, bottom: 60),
                        icon: const Icon(
                          Icons.person_sharp,
                          color: Colors.white,
                          size: 80,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DoctorSignupScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    const Text(
                      'DOCTOR',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
