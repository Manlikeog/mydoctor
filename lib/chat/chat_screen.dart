import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_detail.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return ChatDetail(
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
            .where('isDoctor', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something Went Wrong'),
            );
          }

          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text('People'),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return CupertinoListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(data['profile']),
                            ),
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
        });
  }
}
