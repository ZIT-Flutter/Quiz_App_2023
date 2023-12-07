import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create new account', textScaleFactor: 1.2),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(hintText: 'First Name'),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(hintText: 'Age'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 32),
              if (isSuccess == true)
                Row(
                  children: [
                    Text(
                      'Sign up successful',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.green),
                    ),
                    TextButton(onPressed: () {}, child: Text('Login'))
                  ],
                ),
              SizedBox(height: 32),
              ElevatedButton(
                  onPressed: () async {
                    // isSuccess = await signUp();

                    String? userID = await signUp();

                    if (userID != null) {
                      Map<String, dynamic> data = {
                        'name':
                            '${firstNameController.text} ${lastNameController.text}',
                        'age': int.parse(ageController.text),
                      };

                      isSuccess = await updateUserInfo(userID, data);

                      if (isSuccess) {
                        setState(() {});
                      }
                    }
                  },
                  child: Text('Sign up')),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> signUp() async {
    try {
      var userInfo = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      if (userInfo.user != null) {
        print('Sign up successful');

        print('User ID : ${userInfo.user!.uid}');

        return userInfo.user!.uid;
      }

      // return true;
    } on Exception catch (e) {
      print('Sign up failed :$e');

      // return null;
    }
    return null;
  }

  Future<bool> updateUserInfo(String uid, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('all_user').doc(uid).set(data);
    print('User Data Updated Successfully');

    return true;
  }
}
