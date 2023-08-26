import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessageBox extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String message;

  const ChatMessageBox({
    required this.profileImageUrl,
    required this.username,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFC5CDCE),
        borderRadius: BorderRadius.circular(16),

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileImageUrl),
            radius: 24,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF84949a),

                ),
              ),
              SizedBox(height: 1),
              Text(
                message,
                style: TextStyle(fontSize: 30, color: Color(0xFF84949a),fontFamily: 'Cavet',),

              ),
            ],
          ),
        ],
      ),
    );
  }
}