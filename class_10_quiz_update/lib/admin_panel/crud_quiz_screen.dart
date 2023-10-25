import 'package:class_8_admin_panel/admin_panel/edit_quiz_sheet_widget.dart';
import 'package:class_8_admin_panel/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUDQuizScreen extends StatefulWidget {
  const CRUDQuizScreen({super.key});

  @override
  State<CRUDQuizScreen> createState() => _CRUDQuizScreenState();
}

class _CRUDQuizScreenState extends State<CRUDQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Operations'),
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
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await updateQuiz(currentQuiz.id!);
                                  // showModalBottomSheet(
                                  //     context: context,
                                  //     builder: (context) =>
                                  //         EditQuizBottomSheetWidget(
                                  //             quiz: currentQuiz));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
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
                                              await deleteQuiz(currentQuiz.id!);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                            child: Text('Yes')),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                )),
                          ],
                        ),
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

  Future<void> updateQuiz(String docID) async {
    var documentSnap = await FirebaseFirestore.instance
        .collection('all_quiz')
        .doc(docID)
        .get();

    await documentSnap.reference
        .update({'question': 'Which gas do trees use for photosynthesis?'});

    print('Quiz Updated');
  }
}
