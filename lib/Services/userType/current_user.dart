import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../providers/user.dart';

class CurrentUser extends ChangeNotifier {
  User? loggedInUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? displayName;
  String? photoUrl;
  String? phoneNumber;
  String? address;
  bool? isDoctor;

  List<Users> requests = [];

  Future getCurrentUser() async {
    try {
      var user = await auth.currentUser;

      if (user != null) {
        loggedInUser = user;
        displayName = loggedInUser!.displayName!;
        await getInfo();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future getInfo({bool? update}) async {
    if (kDebugMode) {
      print('updating..');
    }
    displayName = loggedInUser!.displayName!;
    await firestore
        .collection('users')
        .doc(loggedInUser!.uid)
        .get()
        .then((document) {
      if (kDebugMode) {
        print(document.get('photoUrl'));
      }
      displayName = document.data().toString().contains('displayName')
          ? document.get('displayName')
          : '';
      photoUrl = document.data().toString().contains('photoUrl')
          ? document.get('photoUrl')
          : '';
      isDoctor = document.data().toString().contains('isDoctor')
          ? document.get('isDoctor')
          : false;
      phoneNumber = document.data().toString().contains('number')
          ? document.get('number')
          : '';
      address = document.data().toString().contains('address')
          ? document.get('address')
          : '';

      if (kDebugMode) {
        print(displayName);
      }
      notifyListeners();
    });
  }

//  Future getUsersInfo(String uid) async {
//    Map doc;
//    await firestore.collection('users').document('$uid').get().then((document) {
//      String url = document['photoUrl'];
//      String name = document['displayName'];
//      bool isPandit = document['isPandit'];
//      doc = {'photoUrl': url, 'displayName': name, 'isPandit': isPandit};
//    });
//    return doc;
//  }
//
//  Future getUserInfo(String uid) async {
//    Map doc;
//    await firestore.collection('users').document('$uid').get().then((document) {
//      int numConn = document['numConn'];
//      doc = {'numConn': numConn};
//    });
//    return doc;
//  }

  Future getRequests() async {
    requests.clear();
    await firestore
        .collection('users')
        .where('isVerified', isEqualTo: false)
        .get()
        .then((document) async {
      List<DocumentSnapshot> incomingRequests = document.docs;
      for (var request in incomingRequests) {
        requests.add(Users(
          name: request.data().toString().contains('displayName')
              ? request.get('displayName')
              : '',
          photoUrl: request.data().toString().contains('profile')
              ? request.get('profile')
              : '',
          uid: request.data().toString().contains('uid')
              ? request.get('uid')
              : '',
          isDoctor: request.data().toString().contains('isDoctor')
              ? request.get('isDoctor')
              : false,
        ));
      }
    });

    notifyListeners();
  }

  Future acceptRequest(uid, index) async {
    DocumentReference doctorRef =
        FirebaseFirestore.instance.doc('users/' + uid);

    await firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap1 = await transaction.get(doctorRef);

      transaction.update(freshSnap1.reference, {
        'isVerified': true,
      });
    });

    requests.removeAt(index);
    notifyListeners();
  }

  Future declineRequest(uid, index) async {
    DocumentReference doctorRef =
        FirebaseFirestore.instance.doc('users/' + uid);

    await firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap1 = await transaction.get(doctorRef);

      transaction.update(freshSnap1.reference, {
        'isVerified': null,
      });
    });

    requests.removeAt(index);
    notifyListeners();
  }
}
