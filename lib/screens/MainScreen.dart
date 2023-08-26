
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wtf01/Explore.dart';
import 'package:wtf01/HomeScreen1.dart';
import 'package:wtf01/Message.dart';
import 'package:wtf01/Notification.dart';
import 'package:wtf01/Profile.dart';
import 'package:wtf01/screens/search_screen.dart';

import '../chat/group_chats/create_group/add_members.dart';
import '../chat/group_chats/group_chat_screen.dart';
import '../controllers/home_controller.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(HomeContoller());
    FirebaseAuth auth=FirebaseAuth.instance;
    final String? Uid=auth.currentUser!.uid;
    var navbarItem=[
      BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded),label: "Categories"),
      BottomNavigationBarItem(icon: Image.asset('assets/icons/explore.png',width: 40,height: 40),label: 'Explore'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded),label: "Profile"),
      BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: "Profile"),
    ];
    var navBody=[
      const HomeScreen1(),MessageScreen(), AddMembersInGroup(),NotificationPage(),ProfileScreen(uid:FirebaseAuth.instance.currentUser!.uid)

    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value),)),
        ],
      ),
      bottomNavigationBar: Obx(()=>
          BottomNavigationBar(currentIndex: controller.currentNavIndex.value,items: navbarItem,backgroundColor: Colors.white,type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xff1AC3A9),
            selectedIconTheme: IconThemeData(color: Color(0xff1AC3A9)),
            onTap: (value){
              controller.currentNavIndex.value=value;
            },
            selectedLabelStyle: const TextStyle(),),
      ),
    );
  }
}
