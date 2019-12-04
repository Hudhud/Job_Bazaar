import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:place_picker/place_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditTaskScreen extends StatefulWidget {
  final DocumentSnapshot task;

  EditTaskScreen({Key key, this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hourly = false;
  String _title;
  String _description;
  String _payment;
  DateTime _date;
  LocationResult _location;
  final _locationTextFieldsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _paymentController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _paymentController;
  TextEditingController _dateController;

  @override
  void initState() {
    _titleController = TextEditingController(text: (widget.task['title']));
    _descriptionController =
        TextEditingController(text: (widget.task['description']));
    _paymentController =
        TextEditingController(text: (widget.task['payment'].toString()));
    Timestamp date = widget.task['date'];
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd - kk:mm').format(
            DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timestamp dateTimeStamp = widget.task['date'];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        dateTimeStamp.millisecondsSinceEpoch);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
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
                    'Edit Task',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(45),
                    ],
                    onSaved: (value) => _title = value,
                    validator: (value) =>
                        value != "" ? null : "All fields are required",
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Description"),
                    controller: _descriptionController,
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
                    controller: _paymentController,
                    onSaved: (value) => _payment = value.toString(),
                  ),
                  DateTimeField(
                    format: DateFormat("yyyy-MM-dd HH:mm"),
                    decoration: InputDecoration(labelText: "Date & Time"),
                    initialValue: date,
                    controller: _dateController,
                    onSaved: (value) => _date = value,
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
                            Container(
                              color: Colors.orange,
                              child: IconButton(
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
                                    _location = result;
                                  }),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _locationTextFieldsController,
//                                controller : ,
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
                    child: Text("Save Task!"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          _formKey.currentState.save();
                          Firestore.instance
                              .collection('tasks')
                              .document(widget.task.documentID)
                              .updateData({
                            'hourly': _hourly,
                            'title': _title,
                            'description': _description,
                            'payment': double.parse(_payment),
                            'date': _date,
                            'formattedAddress': _location.formattedAddress,
                            'latitude': _location.latLng.latitude,
                            'longitude': _location.latLng.longitude,
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
