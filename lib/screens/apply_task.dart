import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
//        child: Column(
//          children: <Widget>[
//            Container(
//              width: 150.0,
//              height: 150.0,
//              decoration: BoxDecoration(
//                color: Colors.orange,
//                image: DecorationImage(
//                  image: NetworkImage(""),
//                  fit: BoxFit.cover
//                ),
//                borderRadius: BorderRadius.all(Radius.circular(75.0)),
//              ),
//            )
//          ],

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
            margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                    image: NetworkImage("https://img.icons8.com/ios-filled/50/000000/user-male-circle.png"),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.all(Radius.circular(75.0)),
              ),
            ),
            ),
            Center(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 140, right: 140, top: 10),
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

                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Show Interest"),
                            content: Text("Show that you are interested in helping with the task"
                                "the task provider will be notified and can choose to accept you help."
                                "You will reviece a notification in the task provider has accepted your help."),
                            actions: [
                              FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text("close"),
                              )
                            ],
                          );
                        }
                      );
                      try {
                        FirebaseUser user = await FirebaseAuth.instance.currentUser();

                        print(_task.toString());
                        
                        await Firestore.instance.collection('tasks/${_task.id}/applicants').document(user.uid).setData({'status': 'interrested'});

                        // _task.

                        // await Firestore.instance.collection('tasks')
                      } on Exception catch (error) {
                        print(error); //error message here
                      }
                    },
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

