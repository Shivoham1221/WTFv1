import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String postTitle;
  final String username;
  final String postImage;
  final String userProfileImage;
  final String caption;
  final String commentCount;
  final String likeCount;
  final String commentUsername; // Add this property

  const PostWidget({
    required this.postTitle,
    required this.username,
    required this.postImage,
    required this.userProfileImage,
    required this.caption,
    required this.commentCount,
    required this.likeCount,
    required this.commentUsername,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  postTitle,
                  style: TextStyle(
                    fontSize: 28, // Increased font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.more_vert), // Three-dot icon
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make username bold
                  fontSize: 18, // Increased font size
                ),
              ),
              SizedBox(width: 8),
              Text("10s ago"),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  "Follow",
                  style: TextStyle(fontWeight: FontWeight.bold), // Make "Follow" bold
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 200, // Adjust the height as needed
            width: double.infinity, // Make the image width occupy the available space
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(postImage),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 8), // Add some space above the line
          Container(
            width: double.infinity, // Set the line width to match the post's width
            height: 4, // Adjust the line thickness
            color: Colors.grey[300], // Custom line color
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.comment),
              SizedBox(width: 8),
              Text(commentCount),
              SizedBox(width: 16),
              Icon(Icons.favorite),
              SizedBox(width: 8),
              Text(likeCount),
              SizedBox(width: 16),
              Icon(Icons.share),
              SizedBox(width: 8),
              Text(
                "share",
                style: TextStyle(fontWeight: FontWeight.bold), // Make "share" bold
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(userProfileImage),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              commentUsername, // Use the comment username here
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "484",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(caption),
                  ],
                ),
              ),
            ],
          ),







          SizedBox(height: 16),
          Text(
            "Show all $commentCount comments",
            style: TextStyle(fontWeight: FontWeight.bold), // Make "Show all comments" bold
          ),
        ],
      ),
    );
  }
}
//