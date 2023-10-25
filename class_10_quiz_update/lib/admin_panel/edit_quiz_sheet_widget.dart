// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import '../allquiz.dart';

class EditQuizBottomSheetWidget extends StatefulWidget {
  Quiz quiz;

  EditQuizBottomSheetWidget({Key? key, required this.quiz}) : super(key: key);

  @override
  State<EditQuizBottomSheetWidget> createState() =>
      _EditQuizBottomSheetWidgetState();
}

class _EditQuizBottomSheetWidgetState extends State<EditQuizBottomSheetWidget> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answer1Controller = TextEditingController();
  TextEditingController answer2Controller = TextEditingController();
  TextEditingController answer3Controller = TextEditingController();
  TextEditingController answer4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    questionController.text = widget.quiz.question;

    bool isCorrectAnswer1 = widget.quiz.answerList[0].isCorrect;
    bool isCorrectAnswer2 = widget.quiz.answerList[1].isCorrect;
    bool isCorrectAnswer3 = widget.quiz.answerList[2].isCorrect;
    bool isCorrectAnswer4 = widget.quiz.answerList[3].isCorrect;

    answer1Controller.text = widget.quiz.answerList[0].answer;
    answer2Controller.text = widget.quiz.answerList[1].answer;
    answer3Controller.text = widget.quiz.answerList[2].answer;
    answer4Controller.text = widget.quiz.answerList[3].answer;

    print('Device Height = $deviceHeight');

    return Container(
      height: deviceHeight * 0.8,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 214, 242, 250),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: ListView(children: [
        TextField(
          controller: questionController,
          decoration: InputDecoration(helperText: 'Input your Question'),
        ),
        Text('Input All Answers'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: answer1Controller,
                decoration: InputDecoration(helperText: 'Answer 1'),
                onChanged: (value) {
                  answer1Controller.text = value;
                },
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCorrectAnswer1 = !isCorrectAnswer1;
                });
              },
              child: Text(isCorrectAnswer1 ? 'True' : 'False'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: answer2Controller,
                decoration: InputDecoration(helperText: 'Answer 2'),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCorrectAnswer2 = !isCorrectAnswer2;
                });
              },
              child: Text(isCorrectAnswer2 ? 'True' : 'False'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: answer3Controller,
                decoration: InputDecoration(helperText: 'Answer 3'),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCorrectAnswer3 = !isCorrectAnswer3;
                });
              },
              child: Text(isCorrectAnswer3 ? 'True' : 'False'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: answer4Controller,
                decoration: InputDecoration(helperText: 'Answer 4'),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCorrectAnswer4 = !isCorrectAnswer4;
                });
              },
              child: Text(isCorrectAnswer4 ? 'True' : 'False'),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () async {
              // await addQuizToDB();

              print(answer1Controller.text);

              // Navigator.pop(context);
            },
            child: Text('Add to DB'))
      ]),
    );
  }
}
