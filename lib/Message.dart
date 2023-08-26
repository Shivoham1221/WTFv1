import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wtf01/AppHeader.dart';
import 'package:wtf01/DirectChat.dart';
import 'AppFooter.dart';
import 'Profile.dart';
import 'chat/Screens/AnonymousChatRoom.dart';
import 'chat/Screens/ChatRoom.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xfff2f1ec),
        appBar: AppBar(
          backgroundColor: Color(0xfff2f1ec),
          elevation: 0,
          flexibleSpace: Column(
            children: [
              AppHeader(),
              Expanded(child: SizedBox()),
            ],
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: Text(
                  'AM',
                  style: TextStyle(fontSize: 24, color: Color(0xFF365B6D)),
                ),
              ),
              Tab(
                child: Text(
                  'DM',
                  style: TextStyle(fontSize: 24, color: Color(0xFF365B6D)),
                ),
              ),
            ],
            indicatorColor: Color(0xFF365B6D),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [

              AnonymousChat(),
              DirectChat()
            ],
          ),
        ),

      ),
    );
  }

}

class AnonymousChat extends StatefulWidget {
  const AnonymousChat({Key? key}) : super(key: key);

  @override
  State<AnonymousChat> createState() => _AnonymousChatState();
}

class _AnonymousChatState extends State<AnonymousChat> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  final _formKey = GlobalKey<FormState>();

@override
  void initState() {
    // TODO: implement initState
  getAvailableAChats();
    super.initState();
  }
  String chatRoomId(String user1, String user2,String type) {
    return "${type}${user1}${user2}";
    // if (user1[0].toLowerCase().codeUnits[0] >
    //     user2[0].toLowerCase().codeUnits[0]) {
    //   return "${type}${user1}${user2}";
    // } else {
    //   return "${type}${user2}${user1}";
    // }
  }
  void startChat(String id,String name){
    {
      String roomId = chatRoomId(
          _auth.currentUser!.uid!,
          id,"a");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AnonymousChatRoom(
            chatRoomId: roomId,
            uid: id,
            name: name,
          ),
        ),
      );
    }
  }
  List AChatList = [];
  bool isLoading = true;


  void getAvailableAChats() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('AnonymousChat')
    .orderBy("time", descending: true)
        .get()
        .then((value) {
      setState(() {
        AChatList = value.docs;
        print(AChatList);
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
                            startChat((snapshot.data! as dynamic).docs[index]['uid'],(snapshot.data! as dynamic).docs[index]['username'])
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
                            AnonymousChatRoom(chatRoomId: AChatList[index]['id'], uid: AChatList[index]['userId'], name: "name")

                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:  NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          radius: 25,
                        ),
                        title: Text("Anonymous",style: TextStyle(
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



