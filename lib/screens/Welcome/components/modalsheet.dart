// @dart = 2.9

import 'package:flutter/material.dart';
import 'package:mydoctor/screens/Welcome/components/rounded_password.dart';

import '../../../widgets/rounded_button.dart';
import '../../../widgets/rounded_input_field.dart';
import '../Signup/login_screen.dart';

class Modalsheets extends StatefulWidget {
  const Modalsheets({Key key}) : super(key: key);

  @override
  State<Modalsheets> createState() => _ModalsheetsState();
}

class _ModalsheetsState extends State<Modalsheets> {
  final email = TextEditingController();
  final password = TextEditingController();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Describe(
            text1: "Forgot password",
            text2: "Enter your email for the verification process.",
            text3: "We will send 4 digits code to your email",
          ),
          RoundedInputField(
            hintText: "Email",
            focus: _mailFocus,
            type: TextInputType.emailAddress,
            icon: Icons.mail,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your valid email address';
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            controller: email,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: RoundedButton(
              text1: "Continue",
              press: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => FractionallySizedBox(
                    heightFactor: 0.48,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Describe(
                            text1: "Enter 4 Digits Code",
                            text2: "Enter the 4 digits that you received on",
                            text3: "your email.",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Inputfield(onChanged: (value) {}),
                              Inputfield(onChanged: (value) {}),
                              Inputfield(onChanged: (value) {}),
                              Inputfield(onChanged: (value) {}),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: RoundedButton(
                              text1: "Continue",
                              press: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => FractionallySizedBox(
                                    heightFactor: 0.6,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Describe(
                                              text1: "Reset Password",
                                              text2:
                                                  "Set the new password for your account so you can",
                                              text3:
                                                  "login and acess all t he features"),
                                          RoundedPasswordField(
                                            hintText: "New password",
                                            controller: password,
                                            focus: _passwordFocus,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a password';
                                              } else if (!RegExp(
                                                      r'(?=.*?[#?!@$%^&*-])')
                                                  .hasMatch(value)) {
                                                return 'Password must have at least one special character';
                                              }
                                              return null;
                                            },
                                          ),
                                          RoundedPasswordField(
                                            hintText: "Re-enter Password",
                                            controller: password,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a password';
                                              } else if (!RegExp(
                                                      r'(?=.*?[#?!@$%^&*-])')
                                                  .hasMatch(value)) {
                                                return 'Password must have at least one special character';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: RoundedButton(
                                              text1: "Update Password",
                                              press: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return const LoginScreen();
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Describe extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  const Describe({
    Key key,
    this.text1,
    this.text2,
    this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 65,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            text1,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            text2,
            style: const TextStyle(
              color: Color(0xff677294),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 3),
          child: Text(
            text3,
            style: const TextStyle(
              color: Color(0xff677294),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class Inputfield extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const Inputfield({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
      width: size.width * 0.18,
      height: 85,
      child: Center(
        child: TextField(
          cursorColor: const Color(0x9f0EBE7F),
          cursorHeight: 20,
          autocorrect: false,
          textAlign: TextAlign.center,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: "0",
            hintStyle: const TextStyle(
                fontSize: 20,
                color: Color(0x9f0EBE7F),
                fontWeight: FontWeight.w900),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0x3f677294),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0x6f677294),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
