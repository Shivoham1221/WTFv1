
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chat/Screens/AnonymousChatRoom.dart';
import 'chat/Screens/DirectChatRoom.dart';

class DirectChat extends StatefulWidget {
  const DirectChat({Key? key}) : super(key: key);

  @override
  State<DirectChat> createState() => _DirectChatState();
}

class _DirectChatState extends State<DirectChat> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    getAvailableDChats();
    super.initState();
  }
  String chatRoomId(String user1,String user2,String type) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "${type}${user1}${user2}";
    } else {
      return "${type}${user2}${user1}";
    }
  }
  void startChat(String id,String name,String photoUrl){
    {
      String roomId = chatRoomId(
          _auth.currentUser!.uid!,
          id,"d");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DirectChatRoom(
            chatRoomId: roomId,
            uid: id,
            name: name,
            photoUrl: photoUrl,
          ),
        ),
      );
    }
  }
  List AChatList = [];
  bool isLoading = true;


  void getAvailableDChats() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('DirectChat')
        .orderBy("time", descending: true)
        .get()
        .then((value) {
      setState(() {
        AChatList = value.docs;

        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
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
            Container(
                height: 300,
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
                            onTap: () =>{
                              startChat((snapshot.data! as dynamic).docs[index]['uid'],(snapshot.data! as dynamic).docs[index]['username'],(snapshot.data! as dynamic).docs[index]["photoUrl"])
                            },
                            child: ListTile(

                              leading:(snapshot.data! as dynamic).docs[index]['username'].toString().isEmpty?

                              CircleAvatar(
                                backgroundImage:  NetworkImage(
                                    'https://i.stack.imgur.com/l60Hf.png'),
                                radius: 25,
                              ):
                              CircleAvatar(
                                backgroundImage: NetworkImage((snapshot.data! as dynamic).docs[index]['photoUrl']),
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
                Container(
                  height: 300,
                  child:
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: AChatList.length,
                    itemBuilder: (context, index) {
                      return
                        ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) =>

                                    DirectChatRoom(chatRoomId: AChatList[index]['id'], uid: AChatList[index]['userId'], name: AChatList[index]['name'],photoUrl: AChatList[index]['photoUrl'],)

                            ),
                          ),
                          leading: AChatList[index]['photoUrl'].toString().isEmpty?
                          CircleAvatar(
                            backgroundImage:  NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            radius: 25,
                          ):
                          CircleAvatar(
                            backgroundImage:  NetworkImage(
                      AChatList[index]['photoUrl']),
                            radius: 25,
                          )
                          ,
                          title: Text(AChatList[index]['name'],style: TextStyle(
                            fontWeight: FontWeight.bold ,
                            color: Vx.gray700,
                            fontSize: 35,
                            fontFamily: 'Cavet',
                          ),),
                        ).box.height(80).alignCenter.margin(EdgeInsets.all(10)).gray300.customRounded(BorderRadius.all(Radius.circular(25))).make();
                    },
                  ),
                )

            ),

          ],
        ),
      ),
    );
  }
}