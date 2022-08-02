import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Appointment/add_window.dart';
import '../../Appointment/appointment_windows.dart';
import '../Welcome/Signup/login_screen.dart';
import 'doctor_chat.dart';

class DoctorScreen extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  const DoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    const AppointmentWindows(),
    const DoctorChatScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xdf07D9AD),
        title: const Text(
          'Qify',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          // action button
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          // action button
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              });
            },
          ),
          // overflow menu
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff61CEFF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddWindow(
              editState: false,
            );
          }));
        },
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xdf07D9AD),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xff61CEFF),
            icon: Icon(Icons.content_paste),
            label: 'Windows',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded), label: 'Placeholder'),
        ],
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
