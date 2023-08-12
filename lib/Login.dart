import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wtf01/HomeScreen.dart';
import 'Register.dart'; // Import the register screen file

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final email = TextEditingController();
    final password = TextEditingController();

    var Email='';
    var Password='';

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFF365b6d),
      body: Form(
        key: _formKey,
        child: Column(
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
                            child: TextFormField(
                              controller: email,
                              style: TextStyle(
                                color: Color(0xFF365b6d),
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                              decoration: InputDecoration(
                                hintText: 'USERNAME',
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
                            child: TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
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
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                Email=email.text.trim();
                                Password=password.text.trim();
                              });
                              signinUser(Email,Password);
                            }
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
      ),
    );
  }
  void signinUser(String Email,String Password) async {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(""+Phone+Email)));

    try{
      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email:Email, password:Password);
      print(userCredential);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login succesfully")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      //controller.email.clear();
      //controller.password.clear();
      // String? id = FirebaseAuth.instance.currentUser?.uid;
      // UserModel userModel=UserModel(id:id,firstName: firstname, lastName: lastname, email: email, password: password);
      // db.collection("doctor").doc(password).set(userModel.toJson());
    } on FirebaseAuthException catch (e){
      if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password.")));

      }else if(e.code=='invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid email.")));

      }
      else if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("" + e.code.toString())));

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Network Issue.")));

      }
    }
  }

}
