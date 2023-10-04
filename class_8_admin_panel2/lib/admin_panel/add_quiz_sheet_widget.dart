import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddQuizBottomSheetWidget extends StatefulWidget {
  AddQuizBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddQuizBottomSheetWidget> createState() =>
      _AddQuizBottomSheetWidgetState();
}

class _AddQuizBottomSheetWidgetState extends State<AddQuizBottomSheetWidget> {
  TextEditingController quizController = TextEditingController();
  TextEditingController answer1Controller = TextEditingController();
  TextEditingController answer2Controller = TextEditingController();
  TextEditingController answer3Controller = TextEditingController();
  TextEditingController answer4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

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
          controller: quizController,
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
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: () {}, child: Text('True'))
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
            ElevatedButton(onPressed: () {}, child: Text('True'))
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
            ElevatedButton(onPressed: () {}, child: Text('True'))
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
            ElevatedButton(onPressed: () {}, child: Text('True'))
          ],
        ),
        ElevatedButton(
            onPressed: () {
              addQuizToDB();
            },
            child: Text('Add to DB'))
      ]),
    );
  }

  Future<void> addQuizToDB() async {
    var collection = await FirebaseFirestore.instance.collection('all_quiz');

    //A Quiz as Map
    Map<String, dynamic> quizMap = {
      'question': quizController.text,
      'answerList': [
        {'answer': answer1Controller.text, 'isCorrect': false},
        {'answer': answer2Controller.text, 'isCorrect': false},
        {'answer': answer3Controller.text, 'isCorrect': false},
        {'answer': answer4Controller.text, 'isCorrect': false},
      ]
    };

    await collection.add(quizMap);

    print('Quiz is successfully added to Database');
  }
}
