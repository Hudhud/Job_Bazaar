import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_bazaar/models/task.dart';

class ApplyTaskScreen extends StatefulWidget {
  final Task task;

  ApplyTaskScreen({Key key, @required this.task}) : super(key: key);

  @override
  _ApplyTaskScreenState createState() => _ApplyTaskScreenState(task);
}

class _ApplyTaskScreenState extends State<ApplyTaskScreen> {
  final Task _task;

  _ApplyTaskScreenState(this._task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_task.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 140, right: 140, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(20.0)),
                  ),
                  child: Text(_task.hourly? _task.payment.toString() + ' hourly' : _task.payment.toString()),
                ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.orange, fontSize: 15),
                        text: 'Description'),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        text: _task.description),
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.orange, fontSize: 15),
                        text: 'Address'),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        text: _task.formattedAddress),
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.orange, fontSize: 15),
                        text: 'Date & Time'),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        text: _task.date.toString()),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Text('Interested!'),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
