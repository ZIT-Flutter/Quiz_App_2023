import 'package:class_8_admin_panel/user_image_upload_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserImageUploadScreen()));
                },
                child: Text('User Profile Update')),
            Card(
              child: Column(
                children: [
                  Text('Scores', textScaleFactor: 1.2),
                  ListView.builder(itemBuilder: ((context, index) {}))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


//কোডে সমস্যা আছে। ঠিক করতে হবে।
  Future<List<Map<String, dynamic>>> getScoreList() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
List<Map<String, dynamic>> scores = [];
    

   FirebaseFirestore.instance
        .collection('all_user')
        .doc(uid)
        .get()
        .then((snapshot) => {
      if (snapshot.exists) {
         scores = snapshot.data()!['scores'] as List<Map<String, dynamic>>;
        // Access individual maps within the array using their index
        for (int i = 0; i < scores.length; i++) {
          final map = scores[i];
          // Access the map's key-value pairs as needed
          print(map['key1']);
          print(map['key2']);
        }
      }
    });

  }
  
  

