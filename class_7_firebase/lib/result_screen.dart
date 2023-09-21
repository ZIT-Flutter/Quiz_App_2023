// ignore_for_file: prefer_const_constructors

import 'package:class_6/quiz_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int resultScore;
  const ResultScreen({super.key, required this.resultScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Result Screen'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text('Your Score : $QuizScreen'),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text('Go To Home')),
          ],
        ),
      ),
    );
  }
}
