import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'task_detail_screen.dart';

class TaskSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> tasks;

  TaskSearchDelegate(this.tasks)
      : super(
          searchFieldLabel: 'Search tasks',
          searchFieldStyle: TextStyle(fontSize: 16),
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    // Clear the search query
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Back button to dismiss the search
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close the search
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredTasks = tasks.where((task) {
      final title = task['title'].toLowerCase();
      final searchQuery = query.toLowerCase();
      return title.contains(searchQuery);
    }).toList();

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (ctx, index) {
        final task = filteredTasks[index];
        return ListTile(
          title: Text(task['title']),
          subtitle: Text(
            'Due: ${DateFormat('yyyy-MM-dd – kk:mm').format(task['dueDate'])}',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailScreen(
                  title: task['title'],
                  dueDate: task['dueDate'],
                  onEdit: () {
                    Navigator.pop(context); // Close search and return to task list
                    _showEditTaskDialog(context, task);
                  },
                  onDelete: () {
                    Navigator.pop(context); // Close search and return to task list
                    _showDeleteTaskDialog(context, task);
                  },
                  onComplete: () {
                    Navigator.pop(context); // Close search and return to task list
                    _toggleTaskCompletion(context, task);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  void _showEditTaskDialog(BuildContext context, Map<String, dynamic> task) {
    final titleController = TextEditingController(text: task['title']);
    final DateTime selectedDate = task['dueDate'];
    final TimeOfDay selectedTime = TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Task Title'),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select Date'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Time: ${selectedTime.format(context)}',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text('Select Time'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTaskDialog(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Anda Yakin Menghapusnya?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  void _toggleTaskCompletion(BuildContext context, Map<String, dynamic> task) {
    // Implement logic to toggle task completion status here
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // Update selected date
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      // Update selected time
    }
  }
}
