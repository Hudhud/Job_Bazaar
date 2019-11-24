import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Tasks"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 1'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 2'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 3'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 4'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 5'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 6'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 7'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 8'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 9'),
            ),
            ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Job 10'),
            )
          ],
        ));
  }
}
