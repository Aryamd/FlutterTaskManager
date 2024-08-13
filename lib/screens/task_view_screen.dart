import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskViewScreen extends StatelessWidget {
  final String taskId;

  TaskViewScreen({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('tasks').doc(taskId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Task not found.'));
          }

          final task = snapshot.data!;
          final title = task['title'];
          final deadline = task['deadline'].toDate();
          final isCompleted = task['isCompleted'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: $title', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 8),
                Text('Deadline: ${deadline.toLocal().toString().split(' ')[0]}', style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 8),
                Text('Status: ${isCompleted ? "Completed" : "Not Completed"}', style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
                      'isCompleted': !isCompleted,
                    });
                    Navigator.pop(context);
                  },
                  child: Text(isCompleted ? 'Mark as Incomplete' : 'Mark as Completed'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
                    Navigator.pop(context);
                  },
                  child: Text('Delete Task'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
