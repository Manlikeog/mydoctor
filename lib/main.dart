import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mydoctor/Services/authentication/authentication_state.dart';
import 'package:mydoctor/providers/doctors.dart';
import 'package:mydoctor/screens/Welcome/welcome_screen.dart';
import 'package:mydoctor/screens/occupation/occupation.dart';
import 'package:mydoctor/screens/popular/popular_screen.dart';

import 'package:provider/provider.dart';

import 'Services/userType/current_user.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => PopularDoctor(),
        ),
        ChangeNotifierProvider(
          create: (context) => Occupations(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeatureDoctor(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        //0xFFFE871E
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const WelcomeScreen(),
          OccupationScreen.routeName: (ctx) => const OccupationScreen(),
          PopularScreen.routeName: (ctx) => const PopularScreen(),
        },
      ),
    );
  }
}
