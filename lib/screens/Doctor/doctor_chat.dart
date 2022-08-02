import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doctor_chat_detail.dart';

class DoctorChatScreen extends StatefulWidget {
  const DoctorChatScreen({Key? key}) : super(key: key);

  @override
  State<DoctorChatScreen> createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return DoctorChatDetail(
        friendName: name,
        friendUid: uid,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('isDoctor', isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something Went Wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Loading'),
          );
        }

        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text('Patients Available'),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map(
                    (DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return CupertinoListTile(
                          title: Text(data['displayName']),
                          onTap: () {
                            callChatDetailScreen(
                                context, data['displayName'], data['uid']);
                          });
                    },
                  ).toList(),
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
