import 'package:flutter/material.dart';

import 'doctor.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      image: "assets/images/doctor4.jpg",
      title: "Dr. Fillerup ",
      description: "Tooths Dentist",
      years: "7 Years experience",
      percentage: 87,
      patients: "69 Patients Stories",
      id: "1",
      time: "10:00",
      date: "AM tomorrow",
      occupationid: ["Dentist"],
      occupation: "Dentist",
    ),
    Product(
      image: "assets/images/doctor5.png",
      title: "Dr. Watamaniuk",
      description: "Specialist Dentist",
      years: "9 Years experience",
      percentage: 74,
      patients: "70 Patients Stories",
      id: "2",
      time: "12:00",
      date: "AM tomorrow",
      occupationid: ["Dentist"],
      occupation: "Dentist",
    ),
    Product(
      image: "assets/images/doctor6.png",
      title: "Dr. Crownover",
      description: "Pediatric Dentist",
      years: "5 Years experience",
      percentage: 59,
      patients: "86 Patients Stories",
      id: "3",
      time: "11:00",
      date: "AM tomorrow",
      occupationid: ["Dentist"],
      occupation: "Dentist",
    ),
    Product(
      image: "assets/images/doctor7.png",
      title: "Dr. Balestra",
      description: "Tooths Dentist",
      years: "6 Years experience",
      percentage: 72,
      patients: "76 Patients Stories",
      id: "4",
      time: "13:00",
      date: "PM tomorrow",
      occupationid: ["Dentist"],
      occupation: "Dentist",
    ),
    Product(
      image: "assets/images/doctor4.jpg",
      title: "Dr. Transquilli",
      description: "Eyes Specialist",
      years: "3 Years experience",
      percentage: 77,
      patients: "54 Patients Stories",
      id: "5",
      time: "10:00",
      date: "AM tomorrow",
      occupationid: ["Eyes"],
      occupation: "Optician",
    ),
    Product(
      image: "assets/images/doctor5.png",
      title: "Dr. Bonebrake",
      description: "Optician",
      years: "9 Years experience",
      percentage: 23,
      patients: "32 Patients Stories",
      id: "6",
      time: "14:00",
      date: "PM tomorrow",
      occupationid: ["Eyes"],
      occupation: "Optician",
    ),
    Product(
      image: "assets/images/doctor6.png",
      title: "Dr. Whitesell",
      description: "Specialist Optometrist",
      years: "12 Years experience",
      percentage: 88,
      patients: "120 Patients Stories",
      id: "7",
      time: "9:00",
      date: "AM tomorrow",
      occupationid: ["Eyes"],
      occupation: "Optician",
    ),
    Product(
      image: "assets/images/doctor7.png",
      title: "Dr. Brick",
      description: "Ophthalmologist",
      years: "13 Years experience",
      percentage: 52,
      patients: "34 Patients Stories",
      id: "8",
      time: "8:00",
      date: "AM tomorrow",
      occupationid: ["Eyes"],
      occupation: "Optician",
    ),
    Product(
      image: "assets/images/doctor4.jpg",
      title: "Dr. Ether",
      description: "Electrophysiologists",
      years: "4 Years experience",
      percentage: 87,
      patients: "12 Patients Stories",
      id: "9",
      time: "15:00",
      date: "PM tomorrow",
      occupationid: ["Heart"],
      occupation: "Cardiologists",
    ),
    Product(
      image: "assets/images/doctor5.png",
      title: "Dr. Johan",
      description: "interventional cardiologists",
      years: "2 Years experience",
      percentage: 12,
      patients: "32 Patients Stories",
      id: "10",
      time: "12:00",
      date: "PM tomorrow",
      occupationid: ["Heart"],
      occupation: "Cardiologists",
    ),
    Product(
      image: "assets/images/doctor6.png",
      title: "Dr. Crick",
      description: "Cardiac Specialists",
      years: "6 Years experience",
      percentage: 71,
      patients: "41 Patients Stories",
      id: "11",
      time: "18:00",
      date: "PM tomorrow",
      occupationid: ["Heart"],
      occupation: "Cardiologists",
    ),
    Product(
      image: "assets/images/doctor7.png",
      title: "Dr. Strain",
      description: "Adult Heart Specialist",
      years: "3 Years experience",
      percentage: 48,
      patients: "51 Patients Stories",
      id: "12",
      time: "20:00",
      date: "PM tomorrow",
      occupationid: ["Heart"],
      occupation: "Cardiologists",
    ),
    Product(
      image: "assets/images/doctor4.jpg",
      title: "Dr. Lachinet",
      description: "Fitness Trainer",
      years: "2 Years experience",
      percentage: 13,
      patients: "26 Patients Stories",
      id: "13",
      time: "11:00",
      date: "AM tomorrow",
      occupationid: ["Fitness Trainer"],
      occupation: "Fitness Trainer",
    ),
    Product(
      image: "assets/images/doctor5.png",
      title: "Dr. Blessing",
      description: "Fitness Trainer",
      years: "5 Years experience",
      percentage: 90,
      patients: "18 Patients Stories",
      id: "14",
      time: "10:00",
      date: "AM tomorrow",
      occupationid: ["Fitness Trainer"],
      occupation: "Fitness Trainer",
    ),
    Product(
      image: "assets/images/doctor6.png",
      title: "Dr. Truluck",
      description: "Fitness Trainer",
      years: "6 Years experience",
      percentage: 33,
      patients: "46 Patients Stories",
      id: "15",
      time: "11:00",
      date: "AM tomorrow",
      occupationid: ["Fitness Trainer"],
      occupation: "Fitness Trainer",
    ),
    Product(
      image: "assets/images/doctor7.png",
      title: "Dr. Strain",
      description: "Fitness Trainer",
      years: "5 Years experience",
      percentage: 82,
      patients: "61 Patients Stories",
      id: "16",
      time: "10:00",
      date: "AM tomorrow",
      occupationid: ["Fitness Trainer"],
      occupation: "Fitness Trainer",
    ),
  ];
  List<Product> get items {
    return [..._items];
  }

  List<Product> findByWork(String occupationId) {
    return _items.where((occupation) {
      return occupation.occupationid.contains(occupationId);
    }).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}

class Occupations with ChangeNotifier {
  final List<Occupation> _categories = [
    Occupation(
      image: "assets/images/teeth.png",
      work: "Ortho",
      color: [
        const Color(0xff2753F3),
        const Color(0xff765AFC),
      ],
    ),
    Occupation(
      image: "assets/images/heart.png",
      work: "Surgeon",
      color: [
        const Color(0xbf0EBE7E),
        const Color(0xff07D9AD),
      ],
    ),
    Occupation(
      image: "assets/images/eyes.png",
      work: "Optician",
      color: [
        const Color(0xdfFE7F44),
        const Color(0XffFFCF68),
      ],
    ),
    Occupation(
      image: "assets/images/fitness.png",
      work: "Trainer",
      color: [
        const Color(0xcfFF484C),
        const Color(0xffFF6C60),
      ],
    ),
  ];

  List<Occupation> get categories {
    return [..._categories];
  }

  void addCategories() {
    notifyListeners();
  }
}

class PopularDoctor with ChangeNotifier {
  final List<Popular> _popularItem = [
    Popular(
        image: "assets/images/doctor_grab.png",
        text1: "Dr. Fillerup Grab",
        text2: "Medical Specialist",
        color1: const Color(0xffF6D060),
        color2: const Color(0xffF6D060),
        color3: const Color(0xffF6D060),
        color4: const Color(0xffF6D060),
        color5: const Color(0xffF6D060),
        ratings: "2.7"),
    Popular(
        image: "assets/images/doctor10.jpg",
        text1: "Dr. Phillip Johnsons",
        text2: "Heart Surgeon",
        color1: const Color(0xffF6D060),
        color2: const Color(0xffF6D060),
        color3: const Color(0xffF6D060),
        color4: const Color(0xffE2E5EA),
        color5: const Color(0xffE2E5EA),
        ratings: "2.1"),
    Popular(
        image: "assets/images/doctor8.png",
        text1: "Dr. Olivia Baker",
        text2: "Optician",
        color1: const Color(0xffF6D060),
        color2: const Color(0xffF6D060),
        color3: const Color(0xffF6D060),
        color4: const Color(0xffF6D060),
        color5: const Color(0xffE2E5EA),
        ratings: "2.4"),
    Popular(
        image: "assets/images/doctor11.jpg",
        text1: "Dr. Spencer James",
        text2: "Tooth Dentist",
        color1: const Color(0xffF6D060),
        color2: const Color(0xffF6D060),
        color3: const Color(0xffF6D060),
        color4: const Color(0xffF6D060),
        color5: const Color(0xffF6D060),
        ratings: "2.9"),
  ];

  List<Popular> get popularItem {
    return [..._popularItem];
  }

  void addCategories() {
    notifyListeners();
  }
}

class FeatureDoctor with ChangeNotifier {
  final List<Feature> _featureItem = [
    Feature(
      color: Colors.red,
      color2: const Color(0xffF6D060),
      image: "assets/images/doctor12.png",
      rating: "3.7",
      text1: "Dr. Crick",
      text2: "25.00/hours",
    ),
    Feature(
      color: Colors.red,
      color2: const Color(0xffF6D060),
      image: "assets/images/doctor13.png",
      rating: "3.0",
      text1: "Dr. Lachinet",
      text2: "25.00/hours",
    ),
    Feature(
      color: Colors.red,
      color2: const Color(0xffF6D060),
      image: "assets/images/doctor14.png",
      rating: "2.9",
      text1: "Dr. Strain",
      text2: "25.00/hours",
    ),
    Feature(
      color: Colors.red,
      color2: const Color(0xffF6D060),
      image: "assets/images/doctor12.png",
      rating: "3.1",
      text1: "Dr. Crick",
      text2: "25.00/hours",
    ),
    Feature(
      color: Colors.red,
      color2: const Color(0xffF6D060),
      image: "assets/images/doctor13.png",
      rating: "3.5",
      text1: "Dr. Lachinet",
      text2: "25.00/hours",
    ),
  ];

  List<Feature> get featureItem {
    return [..._featureItem];
  }

  void addCategories() {
    notifyListeners();
  }
}
