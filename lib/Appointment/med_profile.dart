import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../Services/userType/current_user.dart';
import '../bottom_bar.dart';
import '../widgets/rounded_input_field.dart';

class MedicalProfile extends StatefulWidget {
  final String? docId;
  const MedicalProfile({Key? key, this.docId}) : super(key: key);
  @override
  _MedicalProfileState createState() => _MedicalProfileState();
}

class _MedicalProfileState extends State<MedicalProfile> {
  bool inProgress = false;

  String? text;
  String? imgUrl;
  List? groups;
  List? groupNames;
  String? groupId;
  double? minPrice;
  double? maxPrice;
  CroppedFile? postImage;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();

  BottomNavigationBar? navigationBar;

  Future uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child(
        'posts/${Provider.of<CurrentUser>(context, listen: false).loggedInUser!.uid} ${DateTime.now().toIso8601String()}');
    UploadTask uploadTask = storageReference.putFile(File(postImage!.path));
    await uploadTask.whenComplete(() => storageReference.getDownloadURL());
    if (kDebugMode) {
      print('File Uploaded');
    }
    storageReference.getDownloadURL().then((fileURL) async {
      await pushData(fileURL);
      setState(() {
        imgUrl = fileURL;
      });
    });
  }

  Future pushData(url) async {
    try {
      if (((textEditingController.text == "") && url == null)) {
        setState(() {
          inProgress = false;
        });
        BotToast.showSimpleNotification(title: 'Nothing to post!');
      } else {
        DocumentReference reference =
            await FirebaseFirestore.instance.collection('medicalRec').add({
          'description': textEditingController.text,
          'image': url != null ? url : null,
          'appointmentStatus': 'Done',
          'uid': Provider.of<CurrentUser>(context, listen: false)
              .loggedInUser!
              .uid,
          'name': Provider.of<CurrentUser>(context, listen: false).displayName,
          'time': FieldValue.serverTimestamp(),
        });
        postImage = null;
        textEditingController.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const BottomBar();
        }));
        setState(() {
          inProgress = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        inProgress = false;
      });
    }
  }

  CroppedFile? _image;
  CroppedFile? croppedImage;

  Future getImage() async {
    setState(() {
      inProgress = true;
    });
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
          compressQuality: 100,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: const Color(0xFF0A0E21),
              toolbarTitle: 'Crop Image',
              backgroundColor: Colors.white,
            ),
          ]);
      setState(() {
        inProgress = false;
        _image = croppedImage;
        postImage = _image;
        if (kDebugMode) {
          print('image: $croppedImage');
        }
      });
    } else {
      setState(() {
        inProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Upload Medical Profile'),
          backgroundColor: Color(0xdf07D9AD)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ModalProgressHUD(
          inAsyncCall: inProgress,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: RoundedInputField(
                        hintText: 'Previous Record Decription',
                        type: TextInputType.multiline,
                        controller: textEditingController,
                        onchanged: (value) {
                          setState(() {
                            text = value;
                          });
                        },
                      )
                      //  TextField(
                      //   textCapitalization: TextCapitalization.sentences,
                      //   keyboardType: TextInputType.multiline,
                      //   maxLines: null,
                      //   controller: textEditingController,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       text = value;
                      //     });
                      //   },
                      //   decoration: const InputDecoration(
                      //     border: InputBorder.none,
                      //     focusedBorder: InputBorder.none,
                      //     enabledBorder: InputBorder.none,
                      //     errorBorder: InputBorder.none,
                      //     disabledBorder: InputBorder.none,
                      //     contentPadding: EdgeInsets.only(
                      //         left: 15, bottom: 11, top: 11, right: 15),
                      //     hintText: 'Problem Description',
                      //   ),
                      // ),
                      ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: const Color(0xff61CEFF),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Pick Image',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            await getImage();
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Visibility(
                          visible: postImage != null ? true : false,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 256,
                                width: 512,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: postImage != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.file(
                                          File(postImage!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : null,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 6),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        postImage = null;
                                      });
                                    },
                                    child: const CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Color(0x00000000),
                                      child:
                                          Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color(0xff61CEFF),
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Upload Previous Record File',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                setState(() {
                                  inProgress = true;
                                });

                                FocusScope.of(context).unfocus();

                                if (postImage != null) {
                                  await uploadFile();
                                } else {
                                  await pushData(null);
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
