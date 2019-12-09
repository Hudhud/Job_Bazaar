import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:job_bazaar/models/task.dart';

class ApplicantScreen extends StatefulWidget {
  final String uid;
  final Task task;

  ApplicantScreen({Key key, @required this.uid, @required this.task})
      : super(key: key);

  @override
  _ApplicantScreenState createState() =>
      _ApplicantScreenState(uid, task);
}

class _ApplicantScreenState extends State<ApplicantScreen> {
  final String _uid;
  final Task _task;

  _ApplicantScreenState(this._uid, this._task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anders Andersen"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          shape: BoxShape.rectangle,
                          color: Colors.orange),
                      child: RatingBar(
                        initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        unratedColor: Colors.black87,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  Container(
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
                                child: Text("18")),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("\nCompleted tasks",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.orange))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("7")),
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
                              .collection('profiles/$_uid/hired_tasks')
                              .document(_task.id)
                              .updateData({
                                'id': _task.id,
                                'title': _task.title,
                                'date': _task.date,
                              });

                          await Firestore.instance
                              .collection('tasks/${_task.id}/applicants')
                              .document(_uid)
                              .updateData({'status': 'hired'});

                          Navigator.of(context).pop();
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 1.5,
                        color: Colors.white,
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(left: 40, right: 8),
                      ),
                      Text('Previouse tasks'),
                      Container(
                        height: 1.5,
                        color: Colors.white,
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(
                          left: 8,
                        ),
                      ),
                    ],
                  ),

                  StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('profiles/$_uid/hired_tasks').snapshots(),

                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return Text('loading....');
                      }
                      return Column(
                        children: snapshot.data.documents.map((doc) {
                        print(doc);

                        return Text('data');
                      }).toList(),
                      );
                    },
                  ),

                  Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'title',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('t'),
                              Icon(Icons.star)
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
