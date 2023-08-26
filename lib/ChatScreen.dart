import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/colors.dart';
import 'AppHeader.dart';
import 'AppFooter.dart';
import 'Profile.dart';
import 'chat/ChatMessageBox.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xfff2f1ec),
        appBar: AppBar(
          backgroundColor: Color(0xfff2f1ec),
          elevation: 0,
          flexibleSpace: AppHeader(), // Assuming AppHeader is a widget
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
              // AM Chats Screen
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ChatMessageBox(
                        profileImageUrl: "Profile Image URL", // Replace with actual image URL
                        username: "Username", // Replace with actual username
                        message: "hi, can we be friends",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ChatMessageBox(
                        profileImageUrl: "Profile Image URL", // Replace with actual image URL
                        username: "Username", // Replace with actual username
                        message: "hi, can we be friends",
                      ),
                    ),
                  ],
                ),
              ),

              // DM Chats Screen
              Center(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        // Search Bar
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFC5CDCE),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                style: TextStyle(
                                  color: Color(0xFF667378),
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search for a user...',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF93A5AC),
                                    fontSize: 25,
                                    fontFamily: 'Cavet',
                                  ),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  setState(() {
                                    isShowUsers = true;
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Color(0xFF365B6D),
                              ),
                              onPressed: () {
                                setState(() {
                                  isShowUsers = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: ChatMessageBox(
                        profileImageUrl: "Profile Image URL", // Replace with actual image URL
                        username: "Username", // Replace with actual username
                        message: "hi, can we be friends",
                      ),
                    ),


                    Expanded(
                      child: isShowUsers
                          ? FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .where(
                          'username',
                          isGreaterThanOrEqualTo: searchController.text,
                        )
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount:
                            (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                      uid: (snapshot.data! as dynamic)
                                          .docs[index]['uid'],
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      (snapshot.data! as dynamic)
                                          .docs[index]['photoUrl'],
                                    ),
                                    radius: 16,
                                  ),
                                  title: Text(
                                    (snapshot.data! as dynamic)
                                        .docs[index]['username'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                          : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .orderBy('datePublished')
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return MasonryGridView.count(
                            crossAxisCount: 3,
                            itemCount:
                            (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) =>
                                Image.network(
                                  (snapshot.data! as dynamic)
                                      .docs[index]['postUrl'],
                                  fit: BoxFit.cover,
                                ),
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}