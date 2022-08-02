import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mydoctor/screens/home/components/popular_card.dart';
import 'package:provider/provider.dart';

class Popular extends StatelessWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            // .orderBy('date')
            .where('isDoctor', isEqualTo: true)
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
          List<PopularCard> tiles = [];
          for (var window in windows) {
            final image = window.data().toString().contains('profile')
                ? window.get('profile')
                : '';
            final userName = window.data().toString().contains('displayName')
                ? window.get('displayName')
                : '';
            final speciality = window.data().toString().contains('speciality')
                ? window.get('speciality')
                : '';

            final docID = window.id;

            if (kDebugMode) {
              print(window.data);
            }

            tiles.add(PopularCard(
              image: image,
              text1: userName,
              text2: speciality,
            ));
          }
          return ListView(
            scrollDirection: Axis.horizontal,
            children: tiles,
          );
        },
      ),

      // ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: products.length,
      //   itemBuilder: (ctx, i) {
      //     return ChangeNotifierProvider.value(
      //       value: products[i],
      //       child: const Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 6),
      //         child: PopularCard(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
