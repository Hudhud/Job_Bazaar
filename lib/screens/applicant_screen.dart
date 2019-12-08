import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class ApplicantScreen extends StatefulWidget {
  final String uid;
  final String taskId;

  ApplicantScreen({Key key, @required this.uid, @required this.taskId})
      : super(key: key);

  @override
  _ApplicantScreenState createState() =>
      _ApplicantScreenState(this.uid, this.taskId);
}

class _ApplicantScreenState extends State<ApplicantScreen> {
  final String _uid;
  final String _taskId;

  _ApplicantScreenState(this._uid, this._taskId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anders Andersen"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: 130.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/kid.png'))),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    height: 40.0,
                    width: 210.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        shape: BoxShape.rectangle,
                        color: Colors.orange),
                    child: RatingBar(
                      initialRating: 3,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ),
                Container(
                    height: 250.0,
                    width: 400.0,
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Age",
                                style: TextStyle(color: Colors.orange)),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("\n18")),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("\nCompleted tasks",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.orange))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("\n7")),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("\nVerification",
                                  style: TextStyle(color: Colors.orange))),
                          Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.done),
                                      Text("NemID")
                                    ],
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.done),
                                      Text("Criminal record")
                                    ],
                                  )),
                            ],
                          ),
                        ])),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 80.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20),
                      ),
                      child: Text('HIRE'),
                      onPressed: () async {
                        await Firestore.instance
                            .collection('tasks')
                            .document(_taskId)
                            .updateData({'hired': _uid});

                        await Firestore.instance
                            .collection('tasks/$_taskId/applicants')
                            .document(_uid)
                            .updateData({'status': 'hired'});

                        Navigator.of(context).pop();
                      },
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
