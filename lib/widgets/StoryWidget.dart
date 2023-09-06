import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final String imagePath; // Image path parameter

  const StoryWidget({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88, // Increased the width
      margin: EdgeInsets.only(left: 4), // Adjusted the margin
      child: Column(
        children: [
          Container(
            width: 72, // Increased the width of the circular profile image
            height: 72, // Increased the height of the circular profile image
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath, // Provide the image asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 2), // Reduced the gap between the profile image and text
        ],
      ),
    );
  }
}
//