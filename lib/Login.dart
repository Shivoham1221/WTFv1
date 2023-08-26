import 'package:flutter/material.dart';
import 'package:wtf01/HomeScreen1.dart';
import 'package:wtf01/chat/Screens/HomeScreen.dart';
import 'package:wtf01/resources/auth_methods.dart';
import 'package:wtf01/screens/MainScreen.dart';
import 'package:wtf01/utils/utils.dart';
import 'Register.dart'; // Import the register screen file

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>MainScreen()
            ),
                (route) => false);

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFF365b6d),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/image/loginLogo.png'),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20), // Adjust this margin as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1AC3A9),
                        fontFamily: 'Cavet',
                      ),
                    ),
                    SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: Color(0xff7d949c),
                        width: 250,
                        height: 55,
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(
                              color: Color(0xFF365b6d),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Color(0xFF365b6d),
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 26),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: Color(0xff7d949c),
                        width: 250,
                        height: 55,
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _passwordController,
                            style: TextStyle(
                              color: Color(0xFF365b6d),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                            obscureText: true,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              hintText: 'PASSWORD',
                              hintStyle: TextStyle(
                                color: Color(0xFF365b6d),
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: 250,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          loginUser();
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
                          'Log in',
                          style: TextStyle(
                            color: Color(0xFF365b6d),
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Handle the forgot password logic
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Text(
                                'Sign up here',
                                style: TextStyle(
                                  color: Colors.white,
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
    );
  }
}
