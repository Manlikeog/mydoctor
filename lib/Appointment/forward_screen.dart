import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/userType/current_user.dart';

import 'forward_windows.dart';
import 'user_tile.dart';

String currentText = "";

class ForwardScreen extends StatefulWidget {
  final String? docID;
  const ForwardScreen({Key? key, this.docID}) : super(key: key);
  @override
  _ForwardScreenState createState() => _ForwardScreenState();
}

class _ForwardScreenState extends State<ForwardScreen> {
  String placeholderText = 'Choose a doctor to forward the case';
  bool searchState = false;

  Color c1 = Colors.grey;
  Color c2 = Colors.grey;
  Color activeC = Colors.pink;
  Color inactiveC = Colors.grey;

  String speciality = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forward Case'),
          backgroundColor: const Color(0xFF0A0E21),
        ),
        backgroundColor: Colors.white,
        body: Consumer<CurrentUser>(
          builder: (context, userData, child) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        prefixStyle: TextStyle(color: Color(0xFF0A0E21)),
                        contentPadding: EdgeInsets.only(
                          top: 14.0,
                        ),
                        border: OutlineInputBorder(
                            //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF0A0E21), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF0A0E21), width: 2.0),
                        ),
                      ),
//                      decoration: kTextFieldDecoration.copyWith(

//                      ),
                      onChanged: (value) {
                        placeholderText = 'No doctor found!';
                        setState(() {
                          currentText = value.toLowerCase();
                          if (!searchState) {
                            searchState = true;
                          } else if (value == "") {
                            searchState = false;
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (c1 == activeC) {
                                  c1 = inactiveC;
                                  speciality = '';
                                } else {
                                  c1 = activeC;
                                  c2 = inactiveC;
                                  speciality = 'false';
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: c1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Doctor',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (c2 == activeC) {
                                  c2 = inactiveC;
                                  speciality = '';
                                } else {
                                  c1 = inactiveC;
                                  c2 = activeC;
                                  speciality = 'true';
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: c2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Speciality',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: speciality == 'false'
                        ? FirebaseFirestore.instance
                            .collection('users')
                            .where('indexList', arrayContains: currentText)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('users')
                            .where('specialityIndex',
                                arrayContains: currentText)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            placeholderText,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }
                      final users = snapshot.data!.docs;
                      List<UserTile> userList = [];
                      for (var user in users) {
                        final userName =
                            user.data().toString().contains('displayName')
                                ? user.get('displayName')
                                : '';
                        final photoUrl =
                            user.data().toString().contains('profile')
                                ? user.get('profile')
                                : '';
                        final uid = user.id;

                        userList.add(
                          UserTile(
                            photoUrl: photoUrl,
                            userName: userName,
                            onPress: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ForwardWindows(
                                  name: userName,
                                  uid: uid,
                                  docID: widget.docID,
                                );
                              }));
                            },
                          ),
                        );
                      }
                      return Expanded(
                        child: userList.isNotEmpty
                            ? ListView(
                                children: userList,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text('No results found for $speciality'),
                              ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
