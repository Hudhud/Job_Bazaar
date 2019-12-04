import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Kr. " + widget.task.data['payment'].toString() + " Hour"),
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
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Desciption\n" + widget.task.data['description']),
              Text("Location\n" + widget.task.data['formattedAddress']),
            ],
          )),
        ],
      ),
    );
  }
}
