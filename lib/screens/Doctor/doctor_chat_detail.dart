import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';

class DoctorChatDetail extends StatefulWidget {
  final friendUid;
  final friendName;

  DoctorChatDetail({Key? key, this.friendUid, this.friendName})
      : super(key: key);

  @override
  _DoctorChatDetailState createState() =>
      _DoctorChatDetailState(friendUid, friendName);
}

class _DoctorChatDetailState extends State<DoctorChatDetail> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final friendUid;
  final friendName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var _textController = new TextEditingController();
  _DoctorChatDetailState(this.friendUid, this.friendName);
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });

              print(chatDocId);
            } else {
              await chats.add({
                'users': {currentUserId: null, friendUid: null},
                'names': {
                  currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                  friendUid: friendName
                }
              }).then((value) => {chatDocId = value});
            }
          },
        )
        .catchError((error) {});
  }

  void sendMessage(String msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName': friendName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chats
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading"),
          );
        }

        if (snapshot.hasData) {
          var data;
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(friendName),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Icon(CupertinoIcons.phone),
              ),
              previousPageTitle: "Back",
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map(
                        (DocumentSnapshot document) {
                          data = document.data()!;
                          print(document.toString());
                          print(data['msg']);
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper3(
                                nipSize: 7,
                                radius: 15,
                                type: isSender(data['uid'].toString())
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble,
                              ),
                              alignment: getAlignment(data['uid'].toString()),
                              margin: EdgeInsets.only(top: 5),
                              backGroundColor: isSender(data['uid'].toString())
                                  ? Colors.blue
                                  : Color(0xffE7E7ED),
                              child: Container(
                                  constraints: BoxConstraints(
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.1,
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.6,
                                  ),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: isSender(data['uid'].toString())
                                            ? Colors.white
                                            : Colors.black),
                                    child: Text(data['msg']),
                                    maxLines: 100,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: CupertinoTextField(
                            controller: _textController,
                          ),
                        ),
                      ),
                      CupertinoButton(
                          child: Icon(Icons.send_sharp),
                          onPressed: () => sendMessage(_textController.text))
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
