import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String image;
  final String title;
  final String description;
  final String years;
  final int percentage;
  final String patients;
  final String id;
  final String time;
  final String date;
  final List<String> occupationid;
  final String occupation;

  bool isFavorite;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.years,
    required this.percentage,
    required this.patients,
    required this.id,
    required this.time,
    required this.date,
    required this.occupationid,
    required this.occupation,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Occupation with ChangeNotifier {
  final String image;
  final String work;
  final List<Color> color;

  Occupation({
    required this.image,
    required this.work,
    required this.color,
  });
}

class Popular with ChangeNotifier {
  final String image;
  final String text1;
  final String text2;
  final String ratings;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  final Color color5;

  Popular({
    required this.image,
    required this.text1,
    required this.text2,
    required this.ratings,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
    required this.color5,
  });
}

class Feature with ChangeNotifier {
  final Color color;
  final Color color2;
  final String image;
  final String rating;
  final String text1;
  final String text2;

  Feature({
    required this.color,
    required this.color2,
    required this.image,
    required this.rating,
    required this.text1,
    required this.text2,
  });
}
