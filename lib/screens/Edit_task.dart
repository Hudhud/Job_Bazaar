import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:place_picker/place_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:job_bazaar/screens/create_task.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:job_bazaar/screens/create_task.dart';



class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key key}) : super(key: key);

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


  final _titleController =  new TextEditingController();
//  String fle = CreateTaskScreen.instance.title;
  final _descriptionController = TextEditingController();
  final _paymentController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();

  var _listener;
  var _transactionListener;

  @override void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    _paymentController.dispose();
    _dateController.dispose();
    _locationController.dispose();

    _transactionListener.cancel();



    super.dispose();
  }


//  TextEditingController _titleController;
//  TextEditingController _descriptionController;
//  TextEditingController _paymentController;
//  TextEditingController _dateController;
//  TextEditingController _locationController;

  @override
  void initState() {
//    _titleController = TextEditingController(text: "Title");
//    _descriptionController = TextEditingController(text: "Description");
//    _paymentController = TextEditingController(text: "Payment (DKK)");
//    _dateController = TextEditingController(text: "Date & Time");
////    _locationController = TextEditingController(text: "Location");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    //code ma
                    controller: _titleController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(45),
                    ],

                    onSaved: (value) => _title = value,
                    validator: (value) => value != ""? null : "All fields are required",
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Description"),
                    //code ma
                    controller: _descriptionController,
//                    onSaved: (value) => _description = value,
                    validator: (value) => value != ""? null : "All fields are required",
                    maxLines: null,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Payment (DKK)"),
                    validator: (value) {
                      if(value == null) {
                        return null;
                      }
                      final n = num.tryParse(value);
                      if(n == null) {
                        return '"$value" is not a valid number';
                      }
                      return null;
                    },
                    //code ma
                    controller: _paymentController,
                    onSaved: (value) => _payment = value,
                  ),
                  DateTimeField(
                    format: DateFormat("yyyy-MM-dd HH:mm"),
                    decoration: InputDecoration(labelText: "Date & Time"),
                    //code ma
                    controller: _dateController,
//                    onSaved: (value) => _date = value,
                    validator: (value) => value.compareTo(DateTime.now()) > 0 ? null : 'Pick a later time',
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

                      // code ma
//                      if (_formKey.currentState.validate()){
//                        CreateTaskScreen.update()
//                      }
//                      final form = _formKey.currentState;
//                      form.save();

//                      if (form.validate()) {
                      if (_formKey.currentState.validate()) {
                        try {
                          FirebaseUser user = await FirebaseAuth.instance.currentUser();
                          await Firestore.instance.collection('tasks').add({
                            'hourly': _hourly,
                            'title': _title,
                            'description': _description,
                            'payment': double.parse(_payment),
                            'date': _date,
                            'place_id': _location.placeId,
                            'creator': user.uid,
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
