import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApplicantScreen extends StatefulWidget {
  final String uid;
  final String taskId;

  ApplicantScreen({Key key, @required this.uid, @required this.taskId}) : super(key: key);

  @override
  _ApplicantScreenState createState() => _ApplicantScreenState(this.uid, this.taskId);
}

class _ApplicantScreenState extends State<ApplicantScreen> {
  final String _uid;
  final String _taskId;

  _ApplicantScreenState(this._uid, this._taskId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_uid),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                  // color: Colors.orange,
                  // textColor: Colors.white,
                  child: Text('HIRE'),
                  onPressed: () async {

                    await Firestore.instance
                    .collection('tasks')
                    .document(_taskId)
                    .updateData({'hired': _uid});

                    await Firestore.instance
                    .collection('tasks/$_taskId/applicants')
                    .document(_uid).updateData({'status': 'hired'});

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
