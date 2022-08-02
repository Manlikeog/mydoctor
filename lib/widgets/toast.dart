import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToasterror(String label) {
  Fluttertoast.showToast(
      msg: label,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red);
}

showToastSuccess(String label) {
  Fluttertoast.showToast(
    msg: label,
    textColor: const Color(0xff0EBE7F),
    gravity: ToastGravity.CENTER,
  );
}
