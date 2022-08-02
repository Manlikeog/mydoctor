import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'forward_screen.dart';

class MedTile extends StatefulWidget {
  final String userName;
  final String content;
  final String postImage;
  final String docId;
  final String? uid;
  final int? index;
  final String status;
  final bool changeStatus;
  final bool cancelAp;
  final Function()? onPress;

  const MedTile({
    Key? key,
    required this.userName,
    required this.content,
    //this.location,
    required this.postImage,
    required this.docId,
    this.uid,
    this.index,
    required this.status,
    required this.changeStatus,
    required this.cancelAp,
    this.onPress,
  }) : super(key: key);

  @override
  _MedTileState createState() => _MedTileState();
}

class _MedTileState extends State<MedTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Patient Name: ',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                        Text(
                          widget.userName,
                          style:
                              const TextStyle(fontSize: 18, letterSpacing: 0.1),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  // ignore: unnecessary_null_comparison
                  visible: widget.content != null ? true : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Record Description: ',
                        style: const TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.15,
                          height: 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.content,
                        style: const TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.15,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Medical Record Image: ',
                  style: const TextStyle(
                    fontSize: 17,
                    letterSpacing: 0.15,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(
                  // ignore: unnecessary_null_comparison
                  visible: (widget.postImage != null) ? true : false,
                  child: const SizedBox(
                    height: 10,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  // ignore: unnecessary_null_comparison
                  visible: (widget.postImage != null) ? true : false,
                  child: Container(
                    height: 256,
                    width: 512,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        widget.postImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Visibility(
                  visible: widget.changeStatus,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Approve',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          DocumentReference doctorRef = FirebaseFirestore
                              .instance
                              .doc('appointments/${widget.docId}');

                          await FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentSnapshot freshSnap1 =
                                await transaction.get(doctorRef);

                            transaction.update(freshSnap1.reference, {
                              'appointmentStatus': 'Approved',
                            });
                          });
                        },
                      ),
                      RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          DocumentReference doctorRef = FirebaseFirestore
                              .instance
                              .doc('appointments/${widget.docId}');

                          await FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentSnapshot freshSnap1 =
                                await transaction.get(doctorRef);

                            transaction.update(freshSnap1.reference, {
                              'appointmentStatus': 'Rejected',
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.cancelAp,
                  child: RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      try {
                        DocumentReference ref = FirebaseFirestore.instance
                            .doc('appointments/${widget.docId}');
                        await FirebaseFirestore.instance
                            .runTransaction((Transaction myTransaction) async {
                          myTransaction.delete(ref);
                        });
                      } catch (e) {
                        BotToast.showSimpleNotification(
                            title: 'Something went wrong :(');
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
