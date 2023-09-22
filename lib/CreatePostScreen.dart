import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostScreen extends StatelessWidget {
  final String currentUsername; // Variable to hold the current username

  // Constructor to receive the current username
  CreatePostScreen({required this.currentUsername});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final captionController = TextEditingController();

    void submitPost() async {
      final title = titleController.text;
      final caption = captionController.text;
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final currentUsername = currentUser.displayName;

        // Access Firestore and add the new post
        await FirebaseFirestore.instance.collection('posts').add({
          'title': title,
          'caption': caption,
          'username': currentUsername, // Include the current username
        });

        // Show a toast message
        Fluttertoast.showToast(
          msg: 'Post Created',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Clear the text fields
        titleController.clear();
        captionController.clear();

        // Navigate back to the previous screen
        Navigator.pop(context);
      } else {
        // Handle the case where the current user is null
        // This should not happen if the user is logged in properly
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add input fields for post content
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: captionController,
                decoration: InputDecoration(labelText: 'Caption'),
              ),
              SizedBox(height: 16.0),

              // Add a button to submit the post
              ElevatedButton(
                onPressed: submitPost,
                child: Text('Submit Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
