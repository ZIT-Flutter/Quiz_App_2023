import 'package:class_8_admin_panel/firebase_auth/create_account_page.dart';
import 'package:class_8_admin_panel/firebase_auth/redirect_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loginFailed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Login'))),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loginFailed == true)
              Text(
                'Login Failed,',
                textScaleFactor: 1.5,
                style: TextStyle(color: Colors.red),
              ),
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
            Row(
              children: [
                Text('Not user?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccountPage(),
                          ));
                    },
                    child: Text('Create Account')),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  bool isLoggedIn = await userLogin();

                  emailController.clear();
                  passwordController.clear();

                  if (isLoggedIn == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RedirectPage()),
                    );
                  } else {
                    setState(() {
                      loginFailed = true;
                    });
                  }
                },
                child: Text('Login'))
          ],
        ),
      )),
    );
  }

  Future<bool> userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      print('Login Successful');

      return true;
    } catch (error) {
      print(error);

      print('Login Failed');

      return false;
    }
  }
}
