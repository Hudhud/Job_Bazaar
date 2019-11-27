import 'package:flutter/material.dart';
import 'package:job_bazaar/auth.dart';
import 'package:job_bazaar/tasks_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child:
      Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        //actions: <Widget>[LogoutButton()],
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            'Home Page Flutter Firebase  Content',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20.0),
          RaisedButton(
              child: Text("LOGOUT"),
              onPressed: () async {
                await Provider.of<AuthService>(context).logout();
              }),
          RaisedButton(
            child: Text("MY TASKS"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TasksPage()),
              );
            },
          ),
        ],
      )),
    ),

    );
  }
}
