import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_bazaar/detail_page.dart';
import 'package:job_bazaar/screens/create_task.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Future getTasks() async {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection('tasks').getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot task) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  task: task,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
      ),
      body: FutureBuilder(
        future: getTasks(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading..."),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                      onTap: () => navigateToDetail(snapshot.data[index]),
                      subtitle: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(snapshot.data[index].data['title']),
                            Text("Kr. " +
                                snapshot.data[index].data['payment']
                                    .toString()),
                            Text(snapshot.data[index].data['description']),
                          ],
                        ),
                      ));
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateTaskScreen()),
          );
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
