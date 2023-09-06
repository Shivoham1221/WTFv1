import 'package:flutter/material.dart';
import 'package:wtf01/widgets/PostWidget.dart';

import 'chat/group_chats/add_members.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  PostWidget(
                    postTitle: "How many times you dress yourself in a day",
                    username: "@baddad24",
                    postImage: "assets/image/postImage1.png",
                    userProfileImage: "assets/image/postIcon.png",
                    caption: "Ladki thoda hun",
                    commentCount: "15",
                    likeCount: "12",
                    commentUsername: 'RacialBible',
                  ),
                  PostWidget(
                    postTitle: "Communal Riots in Haryana: Did the state fail to control the situation?",
                    username: "@jankibaat",
                    postImage: "assets/image/postImage1.png",
                    userProfileImage: "assets/image/postIcon.png",
                    caption: "Ladki thoda hun",
                    commentCount: "35",
                    likeCount: "12",
                    commentUsername: 'Deba Prasad',
                  ),
                  // Add more PostWidgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMembersINGroup(name: '', membersList: [], groupChatId: '',)),
          );
        },
        child: Icon(
          Icons.add,
          size: 42, // Adjust the size as needed
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
//
