// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'admin_panel/admin_panel.dart';
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
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminPanelScreen()));
              },
              child: Text('Admin Panel'),
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            ),
          )
        ],
      )),
    );
  }

  Future<void> addDataToDB() async {
    var collection = await FirebaseFirestore.instance.collection('all_quiz');

    //A Quiz as Map
    Map<String, dynamic> quizMap = {
      'question': 'What is the capital of France?',
      'answerList': [
        {'answer': 'Berlin', 'isCorrect': false},
        {'answer': 'London', 'isCorrect': false},
        {'answer': 'Paris', 'isCorrect': true},
        {'answer': 'Madrid', 'isCorrect': false},
      ]
    };
    //Simple Data
    // var data = {'quiestion': 'What is the capital Of Bangladesh'};

    collection.add(quizMap);
  }
}
