import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  CreateTaskScreen({Key key}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hourly = false;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Create Task',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Title")),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Description"),
                    maxLines: null,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Payment")),
                  DateTimeField(
                    format: DateFormat("yyyy-MM-dd HH:mm"),
                    decoration: InputDecoration(labelText: "Date & Time"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text("Hourly"),
                        Checkbox(
                          value: _hourly,
                          onChanged: (bool value) {
                            setState(() {
                              _hourly = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text("Create Task!"),
                    onPressed: () async {
                      final form = _formKey.currentState;
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
