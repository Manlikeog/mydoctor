import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/userType/current_user.dart';

import 'schedule_tile.dart';

class ForwardWindows extends StatefulWidget {
  final uid;
  final name;
  final docID;
  const ForwardWindows({Key? key, this.name, this.uid, this.docID})
      : super(key: key);
  @override
  _ForwardWindowsState createState() => _ForwardWindowsState();
}

class _ForwardWindowsState extends State<ForwardWindows> {
  Future update(docID) async {
    DocumentReference doctorRef =
        FirebaseFirestore.instance.doc('appointments/' + widget.docID);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap1 = await transaction.get(doctorRef);

      transaction.update(freshSnap1.reference, {
        'appointmentStatus': 'Forwarded to ${widget.name}',
        'doctorWindowID': docID,
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}'s available windows"),
        backgroundColor: const Color(0xFF0A0E21),
      ),
      body: SafeArea(
        child: Consumer<CurrentUser>(
          builder: (context, userData, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Available Appointment Windows',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica Neue',
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('windows')
                        // .orderBy('date')
                        .where('uid', isEqualTo: widget.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "We're getting your scheduled appointment windows ready!",
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }
                      final windows = snapshot.data!.docs;
                      List<ScheduleTile> tiles = [];
                      for (var window in windows) {
                        final title = window.data().toString().contains('title')
                            ? window.get('title')
                            : '';
                        final startTime =
                            window.data().toString().contains('startTime')
                                ? window.get('startTime')
                                : '';
                        final endTime =
                            window.data().toString().contains('endTime')
                                ? window.get('endTime')
                                : '';
                        final date = window.data().toString().contains('date')
                            ? window.get('date')
                            : '';
                        final docID = window.id;

                        print(window.data);

                        tiles.add(
                          ScheduleTile(
                            title: title,
                            startTime: startTime,
                            endTime: endTime,
                            date: date,
                            docId: docID,
                            onPress: () async {
                              await update(docID);
//                            print(docID);
//                            print(widget.name);
//                            print(widget.docID);
                            },
                          ),
                        );
                      }
                      return Expanded(
                        child: tiles.isNotEmpty
                            ? ListView(
                                children: tiles,
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('No appointment windows found'),
                              ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
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
