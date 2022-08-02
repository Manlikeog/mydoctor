import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../Services/userType/current_user.dart';
import '../../bottom_bar.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_input_field.dart';
import '../../widgets/toast.dart';
import 'Signup/login_screen.dart';
import 'Signup/verification.dart';
import 'components/already_have_an_account.dart';
import 'components/description.dart';
import 'components/rounded_password.dart';

class PatientSignupScreen extends StatefulWidget {
  const PatientSignupScreen({Key? key}) : super(key: key);

  @override
  State<PatientSignupScreen> createState() => _PatientSignupScreenState();
}

class _PatientSignupScreenState extends State<PatientSignupScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _civilIdController = TextEditingController();
  final _ageController = TextEditingController();
  final _specialityController = TextEditingController();
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  String? errorText;
  String? mailErrorText;

  bool validateMail = false;
  bool validatePassword = false;
  bool _loading = false;
  bool isSwitched = false;

  CroppedFile? _image;
  String? imgUrl;
  CroppedFile? croppedImage;

  Future getImage() async {
    setState(() {
      _loading = true;
    });
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: Colors.deepPurple,
              toolbarTitle: 'Crop Image',
              backgroundColor: Colors.white,
            ),
          ]);
      setState(() {
        _loading = false;
        _image = croppedImage;
        if (kDebugMode) {
          print('image: $croppedImage');
        }
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  Future uploadFile(c) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
        storage.ref().child('profile/${_mailController.text}');
    UploadTask uploadTask = storageReference.putFile(File(croppedImage!.path));
    await uploadTask.whenComplete(() => storageReference.getDownloadURL());
    if (kDebugMode) {
      print('File Uploaded');
    }
    storageReference.getDownloadURL().then((fileURL) async {
      await signUp(c, fileURL);
      setState(() {
        imgUrl = fileURL;
      });
    });
  }

  Future signUp(c, url) async {
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

        var user = await _auth.createUserWithEmailAndPassword(
            email: _mailController.text, password: _passwordController.text);
        await _auth.currentUser!.updateDisplayName(_nameController.text);

        setState(() {
          _loading = false;
        });

        if (user != null) {
          User? _user = _auth.currentUser;

          await _firestore.collection('users').doc(_user!.uid).set({
            'uid': _user.uid,
            'displayName': _nameController.text,
            'civilId': _civilIdController.text,
            'age': _ageController.text,
            'phone': _phoneController.text,
            'address': _addressController.text,
            'speciality': _specialityController.text,
            'isDoctor': null,
            'isVerified': null,
            'profile': url,
            'indexList': null,
            'specialityIndex': null,
            'timestamp': FieldValue.serverTimestamp(),
          });

          await Provider.of<CurrentUser>(c, listen: false).getCurrentUser();
          Navigator.of(context).popUntil((route) => route.isFirst);
          if (isSwitched == false) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return BottomBar();
            }));
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return VerificationScreen(false);
            }));
          }
        }
      }
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }

  List indexing(name) {
    List<String> splitList = name.split(" ");
    List<String> indexList = [];
    for (var i = 0; i < splitList.length; i++) {
      for (var y = 1; y < splitList[i].length + 1; y++) {
        indexList.add(splitList[i].substring(0, y).toLowerCase());
      }
    }

    return indexList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ModalProgressHUD(
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
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      const Description(
                        text1: "Join us to start searching",
                        text2:
                            """Find Trusted Doctors, Choose the Best Doctors,
                        and Easy Appointments""",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundedInputField(
                        hintText: "Username",
                        icon: Icons.person,
                        controller: _nameController,
                        type: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Age",
                        type: TextInputType.number,
                        icon: Icons.person,
                        controller: _ageController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Age';
                          }
                          return null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Phone",
                        type: TextInputType.phone,
                        icon: Icons.person,
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Phone number';
                          }
                          return null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Address",
                        type: TextInputType.streetAddress,
                        icon: Icons.person,
                        controller: _addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Address';
                          }
                          return null;
                        },
                      ),
                      RoundedInputField(
                        hintText: "Email",
                        type: TextInputType.emailAddress,
                        icon: Icons.mail,
                        controller: _mailController,
                        focus: _mailFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your valid email address';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      RoundedPasswordField(
                        hintText: "Password",
                        controller: _passwordController,
                        focus: _passwordFocus,
                        sub: (value) {
                          signUp(context, null);
                        },
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
                        text1: "Sign Up",
                        press: () {
                          if (_formkey.currentState!.validate()) {
                            signUp(context, null);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      AccountStatus(
                        login: false,
                        press: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
