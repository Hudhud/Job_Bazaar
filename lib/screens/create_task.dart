import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:place_picker/place_picker.dart';

class CreateTaskScreen extends StatefulWidget {
  CreateTaskScreen({Key key}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hourly = false;
  String _title;
  String _description;
  String _payment;
  DateTime _date;
  final _locationTextFieldsController = TextEditingController();

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
                    decoration: InputDecoration(labelText: "Title"),
                    onSaved: (value) => _title = value,
                    validator: (value) =>
                        value != "" ? null : "All fields are required",
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Description"),
                    onSaved: (value) => _description = value,
                    validator: (value) =>
                        value != "" ? null : "All fields are required",
                    maxLines: null,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Payment (DKK)"),
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      final n = num.tryParse(value);
                      if (n == null) {
                        return '"$value" is not a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) => _payment = value,
                  ),
                  DateTimeField(
                    format: DateFormat("yyyy-MM-dd HH:mm"),
                    decoration: InputDecoration(labelText: "Date & Time"),
                    onSaved: (value) => _date = value,
                    validator: (value) => value.compareTo(DateTime.now()) > 0
                        ? null
                        : 'Pick a later time',
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
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.location_searching),
                                onPressed: () async {
                                  LocationResult result = await Navigator.of(
                                          context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => PlacePicker(
                                              'AIzaSyDhmH5I47gLmVD_BtVVWSa9BQC7ogNjiVw')));

                                  // Handle the result in your way
                                  print(result.formattedAddress);
                                  _locationTextFieldsController.text =
                                      result.formattedAddress;
                                }),
                            Expanded(
                              child: TextField(
                                controller: _locationTextFieldsController,
                                enabled: false,
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                      form.save();

                      if (form.validate()) {
                        try {
                          await Firestore.instance.collection('tasks').add({
                            'hourly': _hourly,
                            'title': _title,
                            'description': _description,
                            'payment': double.parse(_payment),
                            'date': _date,
                          });
                          Navigator.of(context).pop();
                        } on Exception catch (error) {
                          return _buildErrorDialog(context, error.toString());
                        }
                      }
                    },
                  ),
                ],
              ),
            )),
      ),
    );
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
}
