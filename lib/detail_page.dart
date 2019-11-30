import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot task;

  DetailPage({this.task});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.task.data['title'])),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.task.data['title']),
            Text(widget.task.data['description']),
            Text(widget.task.data['payment'].toString()),
          ],
        )));
  }
}
