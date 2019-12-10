import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_bazaar/models/task.dart';
import 'package:job_bazaar/screens/pay_screen.dart';
import 'package:job_bazaar/screens/edit_task.dart';
import 'package:job_bazaar/screens/applicant_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Task task;

  PaymentScreen({this.task});

  @override
  _PaymentScreenState createState() => _PaymentScreenState(task);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Task _task;

  _PaymentScreenState(this._task);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('tasks/${_task.id}/applicants')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text(_task.title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditTaskScreen(task: widget.task),
                      ));
                    });
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
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
                            image: AssetImage("images/kid.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        margin: const EdgeInsets.only(
                            left: 140, right: 140, top: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(10.0)),
                        ),
                        child: _task.hourly
                            ? Text(_task.payment.toString() +
                                ' hourly')
                            : Text(_task.payment.toString() +
                                " Kr/ hour")),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    width: 450,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(5.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 15),
                              text: 'Description'),
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))),
                        Text(
                          _task.description,
                        ),
                        SizedBox(height: 20.0),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 15),
                              text: 'Address'),
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15))),
                        Text(_task.formattedAddress),
                        SizedBox(height: 20.0),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 15),
                              text: 'Date & Time'),
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15))),
                        Text(
                          _task.date
                              .toString(),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.orange,
                          textColor: Colors.white,
                          child: Text('pay helper'),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PayScreen(task: _task),
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(left: 80, right: 8),
                      ),
                      Text('Helpers hired'),
                      Container(
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(
                          left: 8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: !snapshot.hasData
                        ? <Widget>[Text('No data...')]
                        : snapshot.data.documents
                            .where((application) =>
                                application.data['status'] == 'hired')
                            .map((application) => InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: new BorderRadius.all(
                                          const Radius.circular(20.0)),
                                    ),
                                    child: Text("Anders Andersen"),
                                  ),
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ApplicantScreen(
                                        uid: application.documentID,
                                        task: _task),
                                  )),
                                ))
                            .toList(),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(left: 60, right: 8),
                      ),
                      Text('Helpers interrested'),
                      Container(
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(
                          left: 8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: !snapshot.hasData
                        ? <Widget>[Text('Loading...')]
                        : snapshot.data.documents
                            .where((application) =>
                                application.data['status'] == 'interested')
                            .map((application) => InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: new BorderRadius.all(
                                          const Radius.circular(20.0)),
                                    ),
                                    child: Text(application.documentID),
                                  ),
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ApplicantScreen(
                                        uid: application.documentID,
                                        task: _task),
                                  )),
                                ))
                            .toList(),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
