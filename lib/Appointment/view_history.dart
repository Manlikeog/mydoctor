import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/userType/current_user.dart';

import 'appointment_tile.dart';

class ViewHistory extends StatefulWidget {
  final String? title;
  final String? windowID;
  const ViewHistory({Key? key, this.title, this.windowID}) : super(key: key);
  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Positioned(
        top: -20,
        left: -20,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Center(
            child: const Text(
              'Appointments History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A0E21),
                fontFamily: 'Helvetica Neue',
                letterSpacing: 0.2,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('appointments')
                // .orderBy('date')
                .where('uid',
                    isEqualTo: Provider.of<CurrentUser>(context, listen: false)
                        .loggedInUser!
                        .uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "We're getting your pending appointment history ready!",
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
                final content = window.data().toString().contains('description')
                    ? window.get('description')
                    : '';
                final windowID =
                    window.data().toString().contains('doctorWindowID')
                        ? window.get('doctorWindowID')
                        : '';
                String status =
                    window.data().toString().contains('appointmentStatus')
                        ? window.get('appointmentStatus')
                        : '';
                final image = window.data().toString().contains('image')
                    ? window.get('image')
                    : '';
                final docID = window.id;

                if (kDebugMode) {
                  print(window.data);
                }

                bool cancelAp;
                try {
                  cancelAp = (status == "Approval Pending" ||
                          status.substring(0, 9) == "Forwarded")
                      ? true
                      : false;
                } catch (e) {
                  cancelAp = false;
                }

                tiles.add(
                  AppointmentTile(
                    userName: name,
                    content: content,
                    postImage: image,
                    status: status,
                    docId: docID,
                    changeStatus: false,
                    cancelAp: cancelAp,
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
        ],
      ),
    ]);
  }
}
