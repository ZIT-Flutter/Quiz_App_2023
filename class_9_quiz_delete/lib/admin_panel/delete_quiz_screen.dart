import 'package:class_8_admin_panel/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteQuizScreen extends StatefulWidget {
  const DeleteQuizScreen({super.key});

  @override
  State<DeleteQuizScreen> createState() => _DeleteQuizScreenState();
}

class _DeleteQuizScreenState extends State<DeleteQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Quiz'),
      ),
      body: FutureBuilder(
          future: Helpers.getAllQuiz(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var currentQuiz = snapshot.data![index];
                      return ListTile(
                        title: Text(currentQuiz.question),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Are you sure?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('No')),
                                          TextButton(
                                              onPressed: () async {
                                                print(currentQuiz.id);
                                                await deleteQuiz(
                                                    currentQuiz.id!);
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Text('Yes')),
                                        ],
                                      ));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            )),
                      );
                    });
              } else {
                return Center(
                  child: Text('No Quiz'),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<void> deleteQuiz(String docID) async {
    var collectionSnapshot =
        await FirebaseFirestore.instance.collection('all_quiz');

    await collectionSnapshot.doc(docID).delete();
  }
}
