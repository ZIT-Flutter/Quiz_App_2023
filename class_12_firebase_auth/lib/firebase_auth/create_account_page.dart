import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                    isSuccess = await signUp();
                    setState(() {});
                  },
                  child: Text('Sign up')),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      print('Sign up successful');

      return true;
    } on Exception catch (e) {
      print('Sign up failed :$e');

      return false;
    }
  }
}
