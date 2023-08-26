import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wtf01/EmailVerification.dart';
import 'package:wtf01/Login.dart';
import 'package:wtf01/resources/auth_methods.dart';
import 'package:wtf01/screens/MainScreen.dart';
import 'package:wtf01/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image=Uint8List.fromList([]);

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        name: _nameController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const EmailVerificationScreen()
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: Color(0xFFf2f1ec),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/image/registerLogo.png'),
              Text(
                'Create new Account',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "MulishBlack",
                  fontWeight: FontWeight.w900,
                  color: Color(0xff1AC3A9),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Username',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xff9b9a95),
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Color(0xffcccbc7),
                                width: 250,
                                height: 55,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TextField(
                                    controller: _usernameController,
                                    style: TextStyle(
                                      color: Color(0xff5e5d5b),
                                      fontSize: 19.0,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.all(12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'EMAIL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff9b9a95),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Color(0xffcccbc7),
                            width: 250,
                            height: 55,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _emailController,
                                style: TextStyle(
                                  color: Color(0xFF5e5d5b),
                                  fontSize: 19.0,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff9b9a95),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Color(0xffcccbc7),
                            width: 250,
                            height: 55,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _nameController,
                                style: TextStyle(
                                  color: Color(0xFF5e5d5b),
                                  fontSize: 19.0,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'PASSWORD',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff9b9a95),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Color(0xffcccbc7),
                            width: 250,
                            height: 55,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _passwordController,
                                style: TextStyle(
                                  color: Color(0xff5e5d5b),
                                  fontSize: 19.0,
                                ),
                                obscureText: true,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Bio',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff9b9a95),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Color(0xffcccbc7),
                            width: 250,
                            height: 55,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _bioController,
                                style: TextStyle(
                                  color: Color(0xff5e5d5b),
                                  fontSize: 19.0,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: 250,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              // Perform sign up logic here
                              signUpUser();
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => LoginPage()),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff1AC3A9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 0,
                              fixedSize: Size.fromHeight(48),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Color(0xFFf2f1ec),
                                fontWeight: FontWeight.w900,
                                fontSize: 19.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        RichText(
                          text: TextSpan(
                            text: 'Already Registered? ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                  child: Text(
                                    'Log in here',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
