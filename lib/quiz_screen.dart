// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quiz_app/allquiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int quizIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                allQuiz[quizIndex].question,
                textScaleFactor: 1.2,
              ),
              Column(
                children: [
                  SizedBox(height: 50),
                  for (Answer answer in allQuiz[quizIndex].answerList)
                    AnswerWidget(myAnswer: answer),
                ],
              ),
              SizedBox(height: 60),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      quizIndex++;
                    });
                  },
                  child: Text('Next Quiz'))
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerWidget extends StatefulWidget {
  final Answer myAnswer;

  const AnswerWidget({Key? key, required this.myAnswer}) : super(key: key);

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  Color answerColor = Colors.indigo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.myAnswer.answer);
        setState(() {
          if (widget.myAnswer.isCorrect == true) {
            answerColor = Colors.green;
          } else {
            answerColor = Colors.red;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: answerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(widget.myAnswer.answer),
      ),
    );
  }
}
