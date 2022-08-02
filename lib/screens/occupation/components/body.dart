import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:mydoctor/screens/occupation/components/card.dart';
import 'package:provider/provider.dart';

import '../../../Appointment/view_windows.dart';
import '../../../widgets/background.dart';
import 'appbar.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as String;

    String placeholderText = 'Choose a doctor to forward the case';
    return Stack(
      children: [
        const Background(),
        const Positioned.fill(
          top: 60,
          child: HomeBar(),
        ),
        Positioned.fill(
            top: 160,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('speciality', isEqualTo: routeArgs)
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
                List<DoctorCard> userList = [];
                for (var user in users) {
                  final userName =
                      user.data().toString().contains('displayName')
                          ? user.get('displayName')
                          : '';
                  final photoUrl = user.data().toString().contains('profile')
                      ? user.get('profile')
                      : '';
                  final age = user.data().toString().contains('age')
                      ? user.get('age')
                      : '';
                  final speciality =
                      user.data().toString().contains('speciality')
                          ? user.get('speciality')
                          : '';
                  final phone = user.data().toString().contains('phone')
                      ? user.get('phone')
                      : '';
                  final address = user.data().toString().contains('address')
                      ? user.get('address')
                      : '';
                  final uid = user.id.toString();
                  userList.add(DoctorCard(
                    image: photoUrl,
                    title: userName,
                    description: speciality,
                    years: age,
                    percentage: phone,
                    date: address,
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewWindows(
                          name: userName,
                          uid: uid,
                        );
                      }));
                    },
                  ));
                }
                return userList.isNotEmpty
                    ? ListView(
                        children: userList,
                        itemExtent: 170,
                        shrinkWrap: true,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('No results found'),
                      );
              },
            )

            // ListView.builder(
            //   itemCount: selectedItem.length,
            //   physics: const AlwaysScrollableScrollPhysics(),
            //   scrollDirection: Axis.vertical,
            //   itemBuilder: (ctx, i) {
            //     return ChangeNotifierProvider.value(
            //       value: selectedItem[i],
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4),
            //         child: DoctorCard(
            //           image: selectedItem[i].image,
            //           title: selectedItem[i].title,
            //           description: selectedItem[i].description,
            //           years: selectedItem[i].years,
            //           percentage: selectedItem[i].percentage,
            //           id: selectedItem[i].id,
            //           date: selectedItem[i].date,
            //         ),
            //       ),
            //     );
            //   },
            //   itemExtent: 170,
            //   shrinkWrap: true,
            // ),
            ),
      ],
    );
  }
}
