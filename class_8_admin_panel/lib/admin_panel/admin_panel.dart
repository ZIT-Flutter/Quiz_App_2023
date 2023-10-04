import 'package:class_8_admin_panel/admin_panel/add_quiz_sheet_widget.dart';
import 'package:flutter/material.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.amber.withOpacity(0),
                    context: context,
                    builder: (context) => AddQuizBottomSheetWidget());
              },
              child: Text('Add Quiz'),
            )
          ],
        ),
      ),
    );
  }
}
