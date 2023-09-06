import 'package:flutter/material.dart';
import 'package:wtf01/AppHeader.dart';
import 'package:wtf01/widgets/StoryWidget.dart';
import 'package:wtf01/widgets/GossipChatWidget.dart';
import 'package:wtf01/chat/group_chats/add_members.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> gossipData = [
    {
      'chatMessage': "Confess your crush in our class",
      'replyCount': "17 replies",
    },
    {
      'chatMessage': "Lets discuss about tomorrows exam",
      'replyCount': "17 replies",
    },
    {
      'chatMessage': "What is this, LMAO",
      'replyCount': "17 replies",
    },
    {
      'chatMessage': "I cant study for tomorrows exam what should I do",
      'replyCount': "17 replies",
    },
    {
      'chatMessage': "I can beat Pulkit in one on",
      'replyCount': "17 replies",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(),
          Container(
            height: 40, // Adjusted height
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFFC5CDCE),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xFF667378),
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search anything...',
                        hintStyle: TextStyle(
                          color: Color(0xFF93A5AC),
                          fontSize: 20,
                          fontFamily: 'Cavet',
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Color(0xFF365B6D),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Updates",
              style: TextStyle(
                color: Color(0xFF365B6D),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return StoryWidget(imagePath: 'assets/image/storyImages/storyImage${(index % 3) + 1}.png');
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Gossips",
              style: TextStyle(
                color: Color(0xFF365B6D),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gossipData.length,
              itemBuilder: (context, index) {
                return GossipChatWidget(
                  chatMessage: gossipData[index]['chatMessage']!,
                  replyCount: gossipData[index]['replyCount']!,
                );
              },
            ),
          ),
        ],
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
