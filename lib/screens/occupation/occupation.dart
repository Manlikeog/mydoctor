// @dart = 2.9

import 'package:flutter/material.dart';

import 'components/body.dart';

class OccupationScreen extends StatefulWidget {
  static const routeName = "/occupationScreen";
  const OccupationScreen({Key key}) : super(key: key);

  @override
  State<OccupationScreen> createState() => _OccupationScreenState();
}

class _OccupationScreenState extends State<OccupationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
