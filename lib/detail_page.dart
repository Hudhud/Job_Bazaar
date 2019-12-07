import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_bazaar/screens/applicant_screen.dart';
import 'package:job_bazaar/screens/edit_task.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot task;

  DetailPage({this.task});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('tasks/${widget.task.documentID}/applicants')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.task.data['title']),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Kr. " +
                      widget.task.data['payment'].toString() +
                      " Hour"),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Searching"),
                      Radio(
                        value: 1,
                        groupValue: selectedRadio,
                        activeColor: Colors.orange,
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                        },
                      ),
                      Text("Assigned"),
                      Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          activeColor: Colors.orange,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio(val);
                          })
                    ],
                  ),
                  Container(
                      height: 200.0,
                      width: 400.0,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Desciption",
                                style: TextStyle(color: Colors.amber)),
                            Text(
                              "\n" + widget.task.data['description'],
                            ),
                            Text("\nLocation",
                                style: TextStyle(color: Colors.amber)),
                            Text("\n" + widget.task.data['formattedAddress']),
                            Text("\nDate & time",
                                style: TextStyle(color: Colors.amber)),
                            Text(
                              "\n" +
                                  DateTime.fromMicrosecondsSinceEpoch(widget
                                          .task
                                          .data['date']
                                          .microsecondsSinceEpoch)
                                      .toString(),
                            ),
                          ])),
                  SizedBox(height: 30),

                  Row(
                    children: <Widget>[
                      Container(
                        height: 1.5,
                        color: Colors.white,
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(left: 50, right: 8),
                      ),
                      Text('Helpers Hired'),
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
                  SizedBox(height: 5,),
                  Column(
                    children: !snapshot.hasData? <Widget>[Text('Loading...')] :
                    snapshot.data.documents
                        .where((application) => application.data['status'] == 'hired')
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
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
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
                        height: 1.5,
                        color: Colors.white,
                        padding: EdgeInsets.all(40),
                        margin: EdgeInsets.only(left: 35, right: 8),
                      ),
                      Text('Helpers interrested'),
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
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: !snapshot.hasData? <Widget>[Text('Loading...')] :
                    snapshot.data.documents
                        .where((application) => application.data['status'] == 'interested')
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
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ApplicantScreen(
                                    uid: application.documentID,
                                    taskId: widget.task.documentID),
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
