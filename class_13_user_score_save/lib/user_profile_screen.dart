import 'package:class_8_admin_panel/user_image_upload_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserImageUploadScreen()));
                },
                child: Text('User Profile Update')),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text('Scores', textScaleFactor: 1.2),
                    FutureBuilder(
                        future: getScoreList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isNotEmpty) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: ((context, index) {
                                    var scoreMap = snapshot.data![index];

                                    final timestamp =
                                        snapshot.data![index]['time'];
                                    final formattedDate =
                                        firestoreTimestampToFormattedDate(
                                            timestamp);
                                    print(
                                        formattedDate); // Output: 12-Dec-2023\n04:42 PM

                                    print(scoreMap);
                                    return Card(
                                      color: Colors.amber.withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${scoreMap['score']}'),
                                            Text('$formattedDate')
                                          ],
                                        ),
                                      ),
                                    );
                                  }));
                            } else {
                              return const Center(
                                child: Text('No Score'),
                              );
                            }
                          } else {
                            return const Center(
                              child: Text('Loading'),
                            );
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String firestoreTimestampToFormattedDate(Timestamp timestamp) {
    final dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    final formatter = DateFormat('dd-MMM-yyyy\nHH:mm a');
    return formatter.format(dateTime.toLocal());
  }

  Future<List<Map<String, dynamic>>> getScoreList() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    List<Map<String, dynamic>> scores = [];

    var docSnap =
        await FirebaseFirestore.instance.collection('all_user').doc(uid).get();

    List dbScores = docSnap.get('scores') as List;

    for (var scoreMap in dbScores) {
      scores.add(scoreMap as Map<String, dynamic>);
    }

    print('Total score: ${scores.length}');

    print(scores);

    return scores;
  }
}
