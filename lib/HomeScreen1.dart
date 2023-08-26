import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wtf01/AppFooter.dart';
import 'package:wtf01/AppHeader.dart';

import 'Profile.dart';
import 'chat/group_chats/group_chat_room.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}
class _HomeScreen1State extends State<HomeScreen1> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
    });
    }

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
  }


  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f1ec),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            AppHeader(),

            TextFormField(

              controller: searchController,
              style: TextStyle(
                color: Color(0xFF667378),
                fontSize: 20,
              ),
              decoration:const  InputDecoration(
                hintText: 'Search anything...',
                hintStyle: TextStyle(
                  color: Color(0xFF93A5AC),
                  fontSize: 23,
                  fontFamily: 'Cavet',
                ),
                border: InputBorder.none,
              ),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
              },
            ).box.gray300.margin(EdgeInsets.all(10)).padding(EdgeInsets.only(left: 15,right: 15,top: 10)).height(50).roundedLg.make(),
            Expanded(

              child: isShowUsers
                  ?
              FutureBuilder(

                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                  'username',
                  isGreaterThanOrEqualTo: searchController.text,
                )
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(0),

                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      if( FirebaseAuth.instance.currentUser!.uid==(snapshot.data! as dynamic).docs[index]['uid']){

                      }
                      else{
                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                uid: (snapshot.data! as dynamic).docs[index]['uid'],
                              ),
                            ),
                          ),
                          child: ListTile(

                            leading:
                            CircleAvatar(
                              backgroundImage:  NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'),
                              radius: 25,
                            ),
                            title: Text(
                              (snapshot.data! as dynamic).docs[index]['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold ,
                                color: Vx.gray700,
                                fontSize: 27,
                                fontFamily: 'Cavet',
                              ),
                            ),
                          ).box.height(80).alignCenter.margin(EdgeInsets.all(10)).gray300.customRounded(BorderRadius.all(Radius.circular(25))).make(),
                        );
                      }

                    },
                  );
                },
              )
                  :

              Column(
                children: [
                  Text("Gossips",style:
                  TextStyle(
                    fontWeight: FontWeight.bold ,
                    color: Vx.gray700,
                    fontSize: 35,
                    fontFamily: 'Cavet',
                  ),),
                  Expanded(
                    child:
                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: groupList.length,
                      itemBuilder: (context, index) {
                        return
                          ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GroupChatRoom(
                                groupName: groupList[index]['name'],
                                groupChatId: groupList[index]['id'],
                              ),
                            ),
                          ),

                          title: Text(groupList[index]['name'],style: TextStyle(
                            fontWeight: FontWeight.bold ,
                            color: Vx.gray700,
                            fontSize: 35,
                            fontFamily: 'Cavet',
                          ),),
                        ).box.height(80).alignCenter.margin(EdgeInsets.all(10)).gray300.customRounded(BorderRadius.all(Radius.circular(25))).make();
                      },
                    ),
                  ),
                ],
              ),

            ),

            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Container(
            //       child: Column(
            //         children: [
            //           Column(
            //             children: [
            //               Text(
            //                 "Latest Games",
            //                 textAlign: TextAlign.left,
            //                 style: TextStyle(
            //                   color: Color(0xFF365B6D),
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 300,
            //                 child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: latestGamesImagesList.length,
            //                   itemBuilder: (context, index) {
            //                     return Padding(
            //                       padding: EdgeInsets.all(20),
            //                       child: Card(
            //                         shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(10),
            //                         ),
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(10),
            //                           child: Image.asset(
            //                             'assets/latestGamesImages/${latestGamesImagesList[index]}.png',
            //                             fit: BoxFit.cover,
            //                           ),
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           ),
            //           Column(
            //             children: [
            //               Text(
            //                 "Updates",
            //                 textAlign: TextAlign.left,
            //                 style: TextStyle(
            //                   color: Color(0xFF365B6D),
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 300,
            //                 child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: updatesImagesList.length,
            //                   itemBuilder: (context, index) {
            //                     return Padding(
            //                       padding: EdgeInsets.all(20),
            //                       child: Card(
            //                         shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(10),
            //                         ),
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(10),
            //                           child: Image.asset(
            //                             'assets/updatesImages/${updatesImagesList[index]}.png',
            //                             fit: BoxFit.cover,
            //                           ),
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

  List<String> latestGamesImagesList = ['pic1','pic2','pic4'];
  List<String> updatesImagesList = ['pic1','pic2'];

