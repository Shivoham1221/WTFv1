import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wtf01/Explore.dart';
import 'package:wtf01/HomeScreen1.dart';
import 'package:wtf01/Login.dart';
import 'package:wtf01/Message.dart';
import 'package:wtf01/OwnProfile.dart';
import 'package:wtf01/resources/auth_methods.dart';
import 'package:wtf01/resources/firestore_methods.dart';
import 'package:wtf01/resources/storage_methods.dart';
import 'package:wtf01/utils/colors.dart';
import 'package:wtf01/utils/utils.dart';
import 'package:wtf01/widgets/follow_button.dart';

import 'AppFooter.dart';
import 'chat/Screens/ChatRoom.dart';
import 'custom_widgets/CustomButton.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;
  Uint8List? _image;
  int _currentIndex = 0;
  var userData = {};
  var myData={};
  int postLen = 0;
  int followers = 0;
  int requests = 0;
  int following = 0;
  bool isInMyRequests=false;
  bool isIFollow=false;
  bool isRequested = false;
  bool isFollowing = false;
  bool isLoading = false;
  String profileImage = '';

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "${user1[0].toLowerCase().codeUnits[0]}${user2.toLowerCase().codeUnits[0]}";
    } else {
      return "${user2.toLowerCase().codeUnits[0]}${user1[0].toLowerCase().codeUnits[0]}";
    }
  }

  void startChat() {
    {
      print(_auth.currentUser!.displayName!.isEmpty
          ? "true"
          : "false" + " // " + userMap!['name']);
      String roomId =
          chatRoomId(_auth.currentUser!.displayName!, userMap!['name']);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatRoom(
            chatRoomId: roomId,
            userMap: userMap!,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var mySnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get()
          .then((value) {
        setState(() {
          userMap = value.data();
          print(userMap);
          isLoading = false;
        });
        print(userMap);
      });

      userData = userSnap.data()!;
      myData=mySnap.data()!;
      print(userData);
      print(myData);
      isInMyRequests=mySnap.data()!['requests']
                          .contains(widget.uid);
      isIFollow=mySnap.data()!['following']
          .contains(widget.uid);
      print(mySnap.data()!['following'].toString()+"  "+widget.uid);
      print(isIFollow);
      followers = userSnap.data()!['followers'].length;
      print("followers${followers}");
      following = userSnap.data()!['following'].length;
      print("following${following}");
      profileImage = userSnap.data()!['photoUrl'];
      isRequested = userSnap
          .data()!['requests']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      isFollowing = userSnap
          .data()!['following']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  uploadImage() async {
    try {
      // Upload the image to Firebase Storage and get the download URL
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', _image!, false);

      // Update the user's document in Firestore with the new photo URL
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid) // Use the user's UID as the document ID
          .update({"photoUrl": photoUrl}).then((_) {
        print('Profile picture updated successfully');
      }).catchError((error) {
        print('Error updating profile picture: $error');
      });

      // Update the profileImage variable in the current state
      setState(() {
        profileImage = photoUrl;
      });
    } catch (e) {
      print('Error uploading profile picture: $e');
    }
  }


  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    // set state because we need to display the image we selected on the circle avatar;
    setState(() {
      _image = im;
      uploadImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xfff2f1ec),
            padding: EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            !userData['photoUrl'].toString().isEmpty
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(profileImage),
                                  )
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://i.stack.imgur.com/l60Hf.png'),
                                  ),
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? Positioned(
                                    bottom: -10,
                                    left: 80,
                                    child: IconButton(
                                      onPressed: selectImage,
                                      icon: const Icon(Icons.add_a_photo),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        SizedBox(width: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '${followers}', // Replace with the actual number of followers
                                    style: TextStyle(
                                        fontSize: 58,
                                        fontFamily: 'WaterLily',
                                        color: Color(0xFF365B6D)) //,
                                    ),
                                SizedBox(height: 8),
                                Text(
                                    'Followers', // Replace with the actual number of followers
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'WaterLily',
                                        color: Color(0xFF365B6D)) //,
                                    ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '${following}', // Replace with the actual number of following
                                    style: TextStyle(
                                        fontSize: 58,
                                        fontFamily: 'WaterLily',
                                        color: Color(0xFF365B6D)) //,
                                    ),
                                SizedBox(height: 8),
                                Text(
                                    'Following', // Replace with the actual number of following
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'WaterLily',
                                        color: Color(0xFF365B6D)) //,

                                    ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userData['username']}',
                          style: TextStyle(
                              fontSize: 38,
                              fontFamily: 'cavet',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF365B6D)),
                        ),
                        SizedBox(height: 8),
                        Text(
                            '${userData['name']}', // Replace with the actual name
                            style: TextStyle(
                                fontSize: 38,
                                fontFamily: 'WaterLily',
                                color: Color(0xFF365B6D)) //,
                            ),
                        SizedBox(height: 8),
                        Text(
                          '${userData['bio']}' +
                              'ok', // Replace with the actual bio
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'cavet',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF365B6D)),
                        ),
                        SizedBox(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     ElevatedButton(
                        //       onPressed: () {
                        //         // Implement follow button action here
                        //       },
                        //       style: ElevatedButton.styleFrom(
                        //         primary: Color(0xff1AC3A9),
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //         ),
                        //         elevation: 0,
                        //         fixedSize: Size.fromHeight(48),
                        //       ),
                        //       child: Text(
                        //         'Follow',
                        //         style: TextStyle(
                        //           color: Color(0xfff2f1ec),
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 19.0,
                        //         ),
                        //       ),
                        //     ),
                        //     ElevatedButton(
                        //       onPressed: () {
                        //         // Implement message button action here
                        //       },
                        //       style: ElevatedButton.styleFrom(
                        //         primary: Color(0xff1AC3A9),
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //         ),
                        //         elevation: 0,
                        //         fixedSize: Size.fromHeight(48),
                        //       ),
                        //       child: Text(
                        //         'Message',
                        //         style: TextStyle(
                        //           color: Color(0xfff2f1ec),
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 19.0,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? CustomButton(
                                    text: 'Sign Out',
                                    onPress: () async {
                                      await AuthMethods().signOut();
                                      if (context.mounted) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ),
                                        );
                                      }
                                    },
                                  ).box.width(context.screenWidth * .9).make()
                                : isInMyRequests?
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  text: 'Accept',
                                  onPress: () async {
                                    await FireStoreMethods()
                                        .acceptUser(
                                      FirebaseAuth
                                          .instance.currentUser!.uid,
                                      userData['uid'],
                                    );

                                    setState(() {
                                      isInMyRequests=false;
                                      isIFollow=true;
                                      following++;
                                    });
                                  },
                                )
                                    .box
                                    .width(context.screenWidth * .4)
                                    .make(),
                                CustomButton(
                                  text: 'Decline',
                                  onPress: () async {
                                    await FireStoreMethods()
                                        .deleteUserRequest(
                                      FirebaseAuth
                                          .instance.currentUser!.uid,
                                      userData['uid'],
                                    );

                                    setState(() {
                                      isInMyRequests=false;
                                    });
                                  },
                                )
                                    .box
                                    .width(context.screenWidth * .4)
                                    .make(),
                              ],
                            )
                                :
                            isRequested?
                            CustomButton(
                    text: 'Requested',
                    onPress: () async {
                      await FireStoreMethods().followRequest(
                        FirebaseAuth
                            .instance.currentUser!.uid,
                        userData['uid'],
                      );

                      setState(() {
                        isRequested=false;
                        // isFollowing = true;
                        // followers++;
                      });
                    },
                  )
                      .box
                      .width(context.screenWidth * .9)
                      .make():
                            isIFollow
                                    ?
                            Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomButton(
                                            text: 'Unfollow',
                                            onPress: () async {
                                              await FireStoreMethods()
                                                  .unfollowUser(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                userData['uid'],
                                              );

                                              setState(() {
                                                isIFollow = false;
                                                following--;
                                              });
                                            },
                                          )
                                              .box
                                              .width(context.screenWidth * .4)
                                              .make(),
                                          CustomButton(
                                            text: 'Message',
                                            onPress: () {
                                              startChat();
                                            },
                                          )
                                              .box
                                              .width(context.screenWidth * .4)
                                              .make(),
                                        ],
                                      )
                                        .box
                                        .width(context.screenWidth * .9)
                                        .make()
                                    : CustomButton(
                                        text: 'Follow',
                                        onPress: () async {
                                          await FireStoreMethods().followRequest(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid'],
                                          );

                                          setState(() {
                                            isRequested=true;
                                            // isFollowing = true;
                                            // followers++;
                                          });
                                        },
                                      )
                                        .box
                                        .width(context.screenWidth * .9)
                                        .make(),
                          ],
                        ),

                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          //   child: Text(
          //     'Suggestions',
          //     textAlign:TextAlign.start ,// Replace with the actual achievements
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),
          //
          // Expanded(child:
          //
          // FutureBuilder(
          //
          //   future: FirebaseFirestore.instance
          //       .collection('users')
          //       .where(
          //     'username',
          //     isGreaterThanOrEqualTo: "harsh",
          //   )
          //       .get(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return ListView.builder(
          //       padding: EdgeInsets.all(0),
          //
          //       itemCount: (snapshot.data! as dynamic).docs.length,
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () => Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) => ProfileScreen(
          //                 uid: (snapshot.data! as dynamic).docs[index]['uid'],
          //               ),
          //             ),
          //           ),
          //           child: ListTile(
          //
          //             leading:
          //             CircleAvatar(
          //               backgroundColor: Colors.lightGreenAccent,
          //               radius: 25,
          //             ),
          //             title: Text(
          //               (snapshot.data! as dynamic).docs[index]['username'],
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold ,
          //                 color: Vx.gray700,
          //                 fontSize: 27,
          //                 fontFamily: 'Cavet',
          //               ),
          //             ),
          //           ).box.height(80).alignCenter.margin(EdgeInsets.all(10)).gray300.customRounded(BorderRadius.all(Radius.circular(25))).make(),
          //         );
          //       },
          //     );
          //   },
          // )
          // ),
        ],
      ),
    );
  }
}
