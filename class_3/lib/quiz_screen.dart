// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'allquiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int quizIndex = 0;

  int? selectedAnswerIndex;

  Color selectedColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Text(
                  allQuiz[quizIndex].question,
                  textScaleFactor: 1.2,
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allQuiz[quizIndex].answerList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAnswerIndex = index;
                            });
                          },
                          child: Card(
                            color: index == selectedAnswerIndex
                                ? selectedColor
                                : Colors.blueAccent.shade700,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(allQuiz[quizIndex]
                                    .answerList[index]
                                    .answer),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        quizIndex++;
                        selectedAnswerIndex = null;
                      });
                    },
                    child: Text('Next Quiz')),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
