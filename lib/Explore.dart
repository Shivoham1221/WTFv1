import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AppFooter.dart';
import 'AppHeader.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 0;

  final List<String> options = ['Opt 1', 'Opt 2', 'Opt 3', 'Opt 4']; // Shorter option texts

  Widget buildOptionButton(String option) {
    signupUser();
    return ElevatedButton(
      onPressed: () {
        // Handle option selection
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xffcccbc8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Reduced horizontal padding
      ),
      child: Text(option),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xfff2f1ec),
        appBar: AppBar(
          backgroundColor: Color(0xfff2f1ec),
          elevation: 0,
          flexibleSpace: AppHeader(),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '1/10',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF365B6D)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Who is the smartest student in our class?',
                      style: TextStyle(fontSize: 38, color: Color(0xFF365B6D), fontFamily: 'Cavet'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: options.map((option) => buildOptionButton(option)).toList(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle Shuffle button tap
                          },
                          child: Text(
                            'Shuffle',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'WaterLily',
                              fontSize: 32,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle Next Poll button tap
                          },
                          child: Text(
                            'Next Poll',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'WaterLily',
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppFooter(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) return;
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
