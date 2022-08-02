import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mydoctor/screens/Welcome/Signup/verification.dart';
import 'package:provider/provider.dart';

import '../../../Appointment/admin_screen.dart';
import '../../../Services/userType/current_user.dart';
import '../../../bottom_bar.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/rounded_input_field.dart';
import '../../../widgets/toast.dart';
import '../components/already_have_an_account.dart';
import '../components/description.dart';
import '../components/modalsheet.dart';
import '../components/rounded_password.dart';
import '../signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? errorText;
  String? mailErrorText;
  bool validateMail = false;
  bool validatePassword = false;
  bool _loading = false;
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future logIn() async {
    setState(() {
      _loading = true;
    });
    try {
      if (_mailController.text.isEmpty) {
        setState(() {
          validateMail = true;

          _loading = false;
        });
      } else if (_passwordController.text.length < 8) {
        setState(() {
          validatePassword = true;
          validateMail = false;

          _loading = false;
        });
      } else {
        setState(() {
          validatePassword = false;
          validateMail = false;
        });

        var user = await _auth.signInWithEmailAndPassword(
            email: _mailController.text, password: _passwordController.text);

        setState(() {
          _loading = false;
        });

        if (user != null) {
          User? _user = _auth.currentUser;
          bool isDoc = false;
          bool admin = false;
          bool isVerified = false;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user!.uid)
              .get()
              .then((document) {
            isDoc = document.data().toString().contains('isDoctor')
                ? document.get('isDoctor')
                : false;
            admin = document.data().toString().contains('admin')
                ? document.get('admin')
                : false;
            isVerified = document.data().toString().contains('isVerified')
                ? document.get('isVerified')
                : false;
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
          await Provider.of<CurrentUser>(context, listen: false)
              .getCurrentUser();
          if (isDoc) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return VerificationScreen(isVerified);
            }));
          } else if (admin) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return AdminScreen();
            }));
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const BottomBar();
            }));
          }
        }
      }
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Stack(
            children: [
              Positioned(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width * 0.2,
                  ),
                  const Description(
                    text1: "Welcome Back",
                    text2: """You can search, book and chat
    with doctors online for free """,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedInputField(
                    hintText: "Email",
                    icon: Icons.mail,
                    type: TextInputType.emailAddress,
                    focus: _mailFocus,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your valid email address';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: _mailController,
                  ),
                  RoundedPasswordField(
                    hintText: "Password",
                    focus: _passwordFocus,
                    sub: (value) => logIn(),
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (!RegExp(r'(?=.*?[#?!@$%^&*-])')
                          .hasMatch(value)) {
                        return 'Password must have at least one special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    text1: "Login",
                    press: () async {
                      if (_formkey.currentState!.validate()) {
                        logIn();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => const FractionallySizedBox(
                          heightFactor: 0.48,
                          child: Modalsheets(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot password",
                      style: TextStyle(
                        color: Color(0xff0EBE7F),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.25),
                  AccountStatus(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const RegistrationScreen();
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
