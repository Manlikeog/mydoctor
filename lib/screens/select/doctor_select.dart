// import 'package:doctorhunt/providers/doctors.dart';
// import 'package:doctorhunt/screens/select/components/background.dart';
// import 'package:doctorhunt/screens/select/components/docotor_select_card.dart';
// import 'package:doctorhunt/screens/select/components/slots.dart';
// import 'package:doctorhunt/screens/select/components/tab.dart';
// import 'package:doctorhunt/widgets/header.dart';
// import 'package:doctorhunt/widgets/rounded_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';

// class DoctorSelectScreen extends StatefulWidget {
//   static const routeName = "/doctorselectScreen";
//   const DoctorSelectScreen({Key? key}) : super(key: key);

//   @override
//   State<DoctorSelectScreen> createState() => _DoctorSelectScreenState();
// }

// class _DoctorSelectScreenState extends State<DoctorSelectScreen>
//     with TickerProviderStateMixin {
//   late TabController? controller = TabController(length: 7, vsync: this);

//   @override
//   Widget build(BuildContext context) {
//     final itemId = ModalRoute.of(context)!.settings.arguments as String;
//     final selectedItem = Provider.of<Products>(
//       context,
//       listen: false,
//     ).findById(itemId);
//     return Scaffold(
//       body: Stack(
//         children: [
//           const Background(),
//           DoctorSelectCard(
//             image: selectedItem.image,
//             title: selectedItem.title,
//           ),
//           Positioned.fill(
//             bottom: 270,
//             child: TabBar(
//               indicatorColor: Colors.transparent,
//               labelPadding: const EdgeInsets.all(6.0),
//               isScrollable: true,
//               controller: controller,
//               onTap: (int tabIndex) {
//                 setState(() {
//                   tabIndex = controller!.index;
//                 });
//               },
//               tabs: [
//                 Tab(
//                   child: Tabs(
//                     text: DateFormat.MMMMEEEEd().format(
//                       DateTime.now().add(
//                         const Duration(days: 0),
//                       ),
//                     ),
//                     color1: controller!.index == 0
//                         ? const Color(0xffffffff)
//                         : const Color(0xff333333),
//                     color2: controller!.index == 0
//                         ? const Color(0xffffffff)
//                         : const Color(0xff677294),
//                     color3: controller!.index == 0
//                         ? const Color(0xff0EBE7F)
//                         : Colors.transparent,
//                   ),
//                 ),
//                 Tab(
//                   child: Tabs(
//                     text: DateFormat.MMMMEEEEd().format(
//                       DateTime.now().add(
//                         const Duration(days: 1),
//                       ),
//                     ),
//                     color1: controller!.index == 1
//                         ? const Color(0xffffffff)
//                         : const Color(0xff333333),
//                     color2: controller!.index == 1
//                         ? const Color(0xffffffff)
//                         : const Color(0xff677294),
//                     color3: controller!.index == 1
//                         ? const Color.fromARGB(240, 31, 190, 135)
//                         : Colors.transparent,
//                   ),
//                 ),
//                 Tab(
//                   child: Tabs(
//                     text: DateFormat.MMMMEEEEd().format(
//                       DateTime.now().add(
//                         const Duration(days: 2),
//                       ),
//                     ),
//                     color1: controller!.index == 2
//                         ? const Color(0xffffffff)
//                         : const Color(0xff333333),
//                     color2: controller!.index == 2
//                         ? const Color(0xffffffff)
//                         : const Color(0xff677294),
//                     color3: controller!.index == 2
//                         ? const Color.fromARGB(240, 31, 190, 135)
//                         : Colors.transparent,
//                   ),
//                 ),
//                 Tab(
//                   child: Tabs(
//                     text: DateFormat.MMMMEEEEd().format(
//                       DateTime.now().add(
//                         const Duration(days: 3),
//                       ),
//                     ),
//                     color1: controller!.index == 3
//                         ? const Color(0xffffffff)
//                         : const Color(0xff333333),
//                     color2: controller!.index == 3
//                         ? const Color(0xffffffff)
//                         : const Color(0xff677294),
//                     color3: controller!.index == 3
//                         ? const Color.fromARGB(240, 31, 190, 135)
//                         : Colors.transparent,
//                   ),
//                 ),
//                 Tab(
//                   child: Tabs(
//                     text: DateFormat.MMMMEEEEd().format(
//                       DateTime.now().add(
//                         const Duration(days: 4),
//                       ),
//                     ),
//                     color1: controller!.index == 4
//                         ? const Color(0xffffffff)
//                         : const Color(0xff333333),
//                     color2: controller!.index == 4
//                         ? const Color(0xffffffff)
//                         : const Color(0xff677294),
//                     color3: controller!.index == 4
//                         ? const Color.fromARGB(240, 31, 190, 135)
//                         : Colors.transparent,
//                   ),
//                 ),
//                 Tab(
//                   child: Tabs(
//                     text: DateFormat.MMMMEEEEd().format(
//                       DateTime.now().add(
//                         const Duration(days: 5),
//                       ),
//                     ),
//                     color1: controller!.index == 5
//                         ? const Color(0xffffffff)
//                         : const Color(0xff333333),
//                     color2: controller!.index == 5
//                         ? const Color(0xffffffff)
//                         : const Color(0xff677294),
//                     color3: controller!.index == 5
//                         ? const Color.fromARGB(240, 31, 190, 135)
//                         : Colors.transparent,
//                   ),
//                 ),
//                 Tab(
//                   child: Tabs(
//                     text: DateFormat.MMMMEEEEd().format(
//                       DateTime.now().add(
//                         const Duration(days: 6),
//                       ),
//                     ),
//                     color1: controller!.index == 6
//                         ? const Color(0xffffffff)
//                         : const Color(0xff333333),
//                     color2: controller!.index == 6
//                         ? const Color(0xffffffff)
//                         : const Color(0xff677294),
//                     color3: controller!.index == 6
//                         ? const Color.fromARGB(240, 31, 190, 135)
//                         : Colors.transparent,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned.fill(
//               top: 310,
//               child: TabBarView(
//                 physics: ScrollPhysics(),
//                 controller: controller,
//                 children: [
//                   selectedItem.isAvailable
//                       ? const NotAvailable()
//                       : const Avalable(),
//                   selectedItem.isAvailable
//                       ? const NotAvailable()
//                       : const Avalable(),
//                   selectedItem.isAvailable
//                       ? const NotAvailable()
//                       : const Avalable(),
//                   selectedItem.isAvailable
//                       ? const NotAvailable()
//                       : const Avalable(),
//                   selectedItem.isAvailable
//                       ? const NotAvailable()
//                       : const Avalable(),
//                   selectedItem.isAvailable
//                       ? const NotAvailable()
//                       : const Avalable(),
//                   selectedItem.isAvailable
//                       ? const NotAvailable()
//                       : const Avalable(),
//                 ],
//               )),
//           const Header(text: "Select Time"),
//         ],
//       ),
//     );
//   }
// }

// class Avalable extends StatelessWidget {
//   const Avalable({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Center(
//           child: Text(
//             DateFormat.MMMMEEEEd().format(
//               DateTime.now().add(
//                 const Duration(days: 1),
//               ),
//             ),
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Text(
//             "Afternoon 7 slots",
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             children: [
//               Slots(text: "1:00 PM"),
//               Slots(text: "1:00 PM"),
//               Slots(text: "1:00 PM"),
//               Slots(text: "1:00 PM"),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Text(
//             "Evening 5 slots",
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             children: [
//               Slots(text: "1:00 PM"),
//               Slots(text: "1:00 PM"),
//               Slots(text: "1:00 PM"),
//               Slots(text: "1:00 PM"),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 140,
//         ),
//         Center(child: RoundedButton(text1: "Book now", press: () {}))
//       ],
//     );
//   }
// }

// class NotAvailable extends StatelessWidget {
//   const NotAvailable({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           DateFormat.MMMMEEEEd().format(
//             DateTime.now().add(
//               const Duration(days: 0),
//             ),
//           ),
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Text(
//           "No slots available ",
//           style: TextStyle(
//             color: Color(0xff677294),
//             fontSize: 15,
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         InkWell(
//           onTap: () {},
//           child: Container(
//             width: 270,
//             height: 50,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: const Color(0xff0EBE7F),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               "Next availaibility on wed 24 Feb",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 17,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Text(
//           "OR",
//           style: TextStyle(
//             color: Color(0xff677294),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: 270,
//           height: 50,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Color(0x7f0EBE7F),
//             ),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Center(
//             child: Text(
//               "Contact Clinic",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Color(0xff0EBE7F),
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
