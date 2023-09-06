import 'package:flutter/material.dart';
//
class GossipChatWidget extends StatelessWidget {
  final String chatMessage;
  final String replyCount;

  const GossipChatWidget({
    required this.chatMessage,
    required this.replyCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Color(0xFFC5CDCE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  chatMessage,
                  style: TextStyle(
                    fontSize: 30, // Adjusted font size
                    color: Color(0xFF365B6D),
                    fontFamily: 'Cavet',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: 0.3, // Adjusted bottom value
                right: 8,
                child: Text(
                  replyCount,
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size
                    color: Color(0xFF365B6D),
                    fontFamily: 'Cavet',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20), // Add white space between chat messages
      ],
    );
  }
}
