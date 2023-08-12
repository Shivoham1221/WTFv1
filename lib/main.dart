import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wtf01/Explore.dart';
import 'package:wtf01/Notification.dart';
import 'package:wtf01/Profile.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/message': (context) => const MessageScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/notification': (context) => NotificationPage(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),

      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfff2f1ec),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: const Text(
                'WTF',
                style: TextStyle(
                  fontSize: 102,
                  color: Color(0xff1AC3A9),
                  fontFamily: 'WaterLily',
                  fontWeight: FontWeight.bold,
                ),

              ),
            ),
            Center(
              child: const Text(
                'Wandering Thoughts forge',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff1AC3A9),
                  fontFamily: 'WaterLily',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
