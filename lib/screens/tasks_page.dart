import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_bazaar/screens/detail_page.dart';
import 'package:job_bazaar/screens/create_task.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
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
        body: FutureBuilder<FirebaseUser>(
            future: FirebaseAuth.instance.currentUser(),
            builder: (_, user) {
              if(user.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('loading'),
                );
              }
              return StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('tasks')
                      .where('creator', isEqualTo: user.data.uid)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading..."),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) {
                            return Container(
                                child: ListTile(
                                    onTap: () => navigateToDetail(
                                        snapshot.data.documents[index]),
                                    subtitle: Container(
                                      width: 75.0,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.0))),
                                      child: Column(
                                        children: <Widget>[
                                          Text(snapshot.data.documents[index]
                                              .data['title']),
                                          Text("Kr. " +
                                              snapshot.data.documents[index]
                                                  .data['payment']
                                                  .toString()),
                                          Text(snapshot.data.documents[index]
                                                      .data['hourly'] ==
                                                  true
                                              ? "per hour"
                                              : "one time"),
                                          Text(snapshot.data.documents[index]
                                              .data['description']),
                                        ],
                                      ),
                                    )));
                          });
                    }
                  });
            }));
  }
}
