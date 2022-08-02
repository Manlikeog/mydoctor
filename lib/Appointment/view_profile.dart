import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../Services/userType/current_user.dart';
import 'appointment_tile.dart';

import 'med_profile.dart';
import 'med_tile.dart';

class ViewProfile extends StatefulWidget {
  final uid;
  final name;
  ViewProfile({this.uid, this.name});
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Medical Profile'),
          backgroundColor: Color(0xdf07D9AD),
          actions: <Widget>[
            Visibility(
              visible: widget.name == null ? false : true,
              child: IconButton(
                icon: Icon(Icons.videocam),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name == null
                    ? '${Provider.of<CurrentUser>(context, listen: false).displayName}'
                    : widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A0E21),
                  fontFamily: 'Helvetica Neue',
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                visible: widget.name != null ? false : true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: const Color(0xff61CEFF),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.lock_open,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return MedicalProfile();
                          }));
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('medicalRec')
                    .where('uid',
                        isEqualTo: widget.uid == null
                            ? '${Provider.of<CurrentUser>(context, listen: false).loggedInUser!.uid}'
                            : widget.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
                    return Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "We're getting your medical records ready!",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                  final windows = snapshot.data!.docs;
                  List<MedTile> tiles = [];
                  for (var window in windows) {
                    final name = window.data().toString().contains('name')
                        ? window.get('name')
                        : '';
                    final content =
                        window.data().toString().contains('description')
                            ? window.get('description')
                            : '';
                    String status =
                        window.data().toString().contains('appointmentStatus')
                            ? window.get('appointmentStatus')
                            : '';
                    final image = window.data().toString().contains('image')
                        ? window.get('image')
                        : '';
                    final docID = window.id;

                    print(window.data);

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
                      MedTile(
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
                    child: tiles.length != 0
                        ? ListView(
                            children: tiles,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text('No appointment windows found'),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
