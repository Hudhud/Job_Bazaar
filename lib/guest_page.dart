import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_bazaar/signup_page.dart';

class GuestPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You are not logged in."),
        //actions: <Widget>[LogoutButton()],
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          RaisedButton(child: Text("Login"), onPressed: () async {}),
          SizedBox(height: 20.0),
          RaisedButton(
              child: Text("Sign Up"),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              })
        ],
      )),
    );
  }
}
