import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wtf01/Login.dart';

import 'Models/UserModel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final dob = TextEditingController();
  var db = FirebaseFirestore.instance;

  String Email="";
  String Password='';
  String DOB='';
  String Name='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: Color(0xFFf2f1ec),
      body: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/image/registerLogo.png'),
                const Text(
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
                                    'NAME',
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
                                      controller: name,
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
                                child: TextFormField(
                                  controller: email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
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
                                child: TextFormField(
                                  controller: password,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    return null;
                                  },
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
                                'DATE OF BIRTH',
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
                                  controller: dob,
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
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    Email=email.text.trim();
                                    Password=password.text.trim();
                                    DOB=dob.text.trim();
                                    Name=name.text.trim();

                                  });
                                  signupUser();
                                }
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
      ),
    );

  }
  void signupUser() async {
    try{
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: Password);
      print(userCredential);
      addUserData();
      //String? id = FirebaseAuth.instance.currentUser?.uid;
      // UserModel userModel=UserModel(id:id,firstName: firstname, lastName: lastname, email: email, password: password);
      // db.collection("doctor").doc(password).set(userModel.toJson());
    } on FirebaseAuthException catch (e){
      if(e.code=='email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already in use.")));

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Network Issue.")));

      }
    }

  }

  // For adding the new user
  void addUserData() async{
    try{
      String? id = FirebaseAuth.instance.currentUser?.uid;
      UserModel userModel=UserModel(id:id,name: Name, email: Email, password: Password,phone:"123456");
      db.collection("User").doc(id).set(userModel.toJson());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered succesfully")));
    }
    catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Network Issue")));

    }
  }

}
