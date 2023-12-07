// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? imagefile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(),
                  image: imagefile != null
                      ? DecorationImage(
                          image: FileImage(
                            imagefile!,
                          ),
                          fit: BoxFit.cover)
                      : null),
              child: imagefile == null ? Center(child: Text('No Image')) : null,
            ),
            ElevatedButton(
                onPressed: () async {
                  imagefile = await pickImage();
                  if (imagefile != null) {
                    setState(() {});

                    String? imageLink = await getImageLink(imagefile!);

                    print('Image Link is : $imageLink');
                  }
                },
                child: Text('Upload Image'))
          ],
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    // final picker = ImagePicker();

    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<String?> getImageLink(File image) async {
    final fileName = basename(image.path);
    final destination = 'userImage/$fileName';

    final reference = FirebaseStorage.instance.ref(destination);

    UploadTask? task = reference.putFile(image);

    if (task == null) {
      return null;
    } else {
      final snapshot = await task.whenComplete(() {});

      String imageLink = await snapshot.ref.getDownloadURL();

      return imageLink;
    }
  }
}
