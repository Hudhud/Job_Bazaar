import 'package:flutter/material.dart';

class ApplicantScreen extends StatefulWidget {
  final String uid;

  ApplicantScreen({Key key, @required this.uid}) : super(key: key);

  @override
  _ApplicantScreenState createState() => _ApplicantScreenState(this.uid);
}

class _ApplicantScreenState extends State<ApplicantScreen> {
  final String _uid;

  _ApplicantScreenState(this._uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_uid),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                  color: Colors.orange,
                  textColor: Colors.white,
                  child: Text('HIRE'),
                  onPressed: () {
                    print(_uid);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
