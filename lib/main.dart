import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wtf01/Explore.dart';
import 'package:wtf01/Notification.dart';
import 'package:wtf01/Profile.dart';
import 'package:wtf01/screens/MainScreen.dart';
import 'package:wtf01/screens/SplashScreen.dart';
import 'dart:async';
import 'HomeScreen.dart';
import 'Login.dart';
import 'Register.dart';
import 'Message.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Mulish_Regular',
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), 
    );
  }
}

