import 'package:flutter/material.dart';
import 'package:wtf01/widgets/PostWidget.dart';
import 'chat/group_chats/add_members.dart';
import 'CreatePostScreen.dart'; // Import the CreatePost screen
import 'package:cloud_firestore/cloud_firestore.dart';


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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(); // Show a loading indicator while fetching data
            }

            final posts = snapshot.data!.docs;
            final postCount = posts.length;

            // Check if there are no posts
            if (postCount == 0) {
              return Center(child: Text('No Posts Available'));
            }

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final post = posts[index];
                      final caption = post['caption'];
                      final title = post['title'];
                      final username = post['username'];

                      return PostWidget(
                        postTitle: title,
                        username: username, // You can set the username as needed
                        postImage: "assets/image/postImage1.png", // You can set the post image as needed
                        userProfileImage: "assets/image/postIcon.png", // You can set the user profile image as needed
                        caption: caption,
                        commentCount: "15",
                        likeCount: "12",
                        commentUsername: 'RacialBible',
                      );
                    },
                    childCount: postCount, // Display as many posts as there are in the database
                  ),
                ),
              ],
            );
          },
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

      // Add the "Create New Post" button below the floatingActionButton
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the CreatePost screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostScreen(currentUsername: '',)),
                );
              },
              child: Text("Create New Post"),
            ),
          ],
        ),
      ),
    );
  }
}
