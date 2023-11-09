import 'package:class_8_admin_panel/admin_panel/crud_quiz_screen.dart';
import 'package:flutter/material.dart';

import 'add_quiz_sheet_widget.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.amber.withOpacity(0),
                      context: context,
                      builder: (context) => AddQuizBottomSheetWidget());
                },
                child: Text('Add Quiz')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CRUDQuizScreen()));
                },
                child: Text('CRUD Operation'))
          ],
        ),
      ),
    );
  }
}
