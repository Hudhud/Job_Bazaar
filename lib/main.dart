import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task List', home: new TaskList());
  }
}

class TaskList extends StatefulWidget {
  @override
  createState() => new TaskListState();
}

class TaskListState extends State<TaskList> {
  List<String> _taskItems = [];

  void _addTaskItem() {
    setState(() {
      int index = _taskItems.length;
      _taskItems.add('Item ' + index.toString());
    });
  }

  Widget _buildTaskList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _taskItems.length) {
          return _buildTaskItem(_taskItems[index]);
        }
      },
    );
  }

  Widget _buildTaskItem(String taskText) {
    return new ListTile(title: new Text(taskText));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Task List')),
      body: _buildTaskList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addTaskItem,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
