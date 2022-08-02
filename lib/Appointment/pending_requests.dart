import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'appointment_tile.dart';
import 'view_profile.dart';

class PendingRequests extends StatefulWidget {
  final String? title;
  final String? windowID;
  const PendingRequests({Key? key, this.title, this.windowID})
      : super(key: key);
  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('${widget.title}'),
          backgroundColor: const Color(0xdf07D9AD)),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('appointments')
                  // .orderBy('date')
                  .where('doctorWindowID', isEqualTo: widget.windowID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "We're getting your pending appointment requests ready!",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                final windows = snapshot.data!.docs;
                List<AppointmentTile> tiles = [];
                for (var window in windows) {
                  final name = window.data().toString().contains('name')
                      ? window.get('name')
                      : '';
                  final content =
                      window.data().toString().contains('description')
                          ? window.get('description')
                          : '';
                  final windowID =
                      window.data().toString().contains('doctorWindowID')
                          ? window.get('doctorWindowID')
                          : '';
                  final status =
                      window.data().toString().contains('appointmentStatus')
                          ? window.get('appointmentStatus')
                          : '';
                  final image = window.data().toString().contains('image')
                      ? window.get('image')
                      : '';
                  final uid = window.data().toString().contains('uid')
                      ? window.get('uid')
                      : '';
                  final docID = window.id;

                  print(window.data);

                  bool changeStatus;

                  try {
                    changeStatus = (status == "Approval Pending" ||
                            status.substring(0, 9) == "Forwarded")
                        ? true
                        : false;
                  } catch (e) {
                    changeStatus = false;
                  }

                  tiles.add(
                    AppointmentTile(
                        userName: name,
                        content: content,
                        postImage: image,
                        status: status,
                        docId: docID,
                        changeStatus: changeStatus,
                        cancelAp: false,
                        onPress: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewProfile(
                              uid: uid,
                              name: name,
                            );
                          }));
                        }),
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
          ],
        ),
      ),
    );
  }
}
