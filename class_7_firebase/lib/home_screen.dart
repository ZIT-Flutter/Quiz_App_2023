// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz App',
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          SizedBox(height: 200),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizScreen()));
            },
            child: Text('Start Quiz'),
            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          ),
          ElevatedButton(
            onPressed: () {
              addDataToDB();
            },
            child: Text('Add Quiz'),
            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          )
        ],
      )),
    );
  }

  Future<void> addDataToDB() async {
    var collection = await FirebaseFirestore.instance.collection('all_quiz');

    var data = {'quiestion': 'What is the capital Of Bangladesh'};

    collection.add(data);
  }
}
