import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_bazaar/screens/applicant_screen.dart';
import 'package:job_bazaar/screens/tasks_page.dart';
import 'package:slider_button/slider_button.dart';

class PayScreen extends StatefulWidget {
  final DocumentSnapshot task;

  PayScreen({this.task});

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String _pay = "paid";

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('tasks/${widget.task.documentID}/applicants')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Payment"),
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
                  SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(30),
                        margin: EdgeInsets.only(left: 80, right: 8),
                      ),
                      Text('Completed Task'),
                      Container(
                        alignment: Alignment.center,
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(30),
                        margin: EdgeInsets.only(
                          left: 8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
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
                                        taskId: widget.task.documentID),
                                  )),
                                ))
                            .toList(),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(50),
                        margin: EdgeInsets.only(left: 60, right: 8),
                      ),
                      Text('Payment'),
                      Container(
                        height: 1.5,
                        color: Color.fromRGBO(100, 100, 100, 50),
                        padding: EdgeInsets.all(30),
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
                                        taskId: widget.task.documentID),
                                  )),
                                ))
                            .toList(),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Center(
                      child: SliderButton(
                    action: () async {
                      try {
                        Firestore.instance
                            .collection(
                                'tasks/${widget.task.documentID}/applicants/${widget.task.documentID}')
                            .document(
                                'tasks/${widget.task.documentID}/applicants/${widget.task.documentID}')
                            .updateData({
                          'status': _pay,
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TasksPage(),
                        ));
                      } on Exception catch (error) {
                        return _buildErrorDialog(context, error.toString());
                      }
                    },
                    label: Text(
                      "SLIDE TO PAY",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                    ),
                    icon: Text(
                      ">",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 44,
                      ),
                    ),
                  )),
                ],
              ),
            ));
      },
    );
  }
}

Future _buildErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Error Message'),
        content: Text(_message),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
