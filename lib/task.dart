import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  Task(
      {@required this.date,
      @required this.description,
      @required this.hourly,
      @required this.payment,
      @required this.title});

  final date;
  final description;
  final hourly;
  final payment;
  final title;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(title),
          Text("Kr. " + payment.toString()),
          Text(description),
        ],
      ),
    ));
  }
}
