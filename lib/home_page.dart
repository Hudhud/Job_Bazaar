import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_bazaar/auth.dart';
import 'package:job_bazaar/screens/create_task.dart';
import 'package:provider/provider.dart';
import 'package:job_bazaar/tasks_page.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser currentUser;

  HomePage(this.currentUser);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Text(
            "Welcome ${widget.currentUser.email}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateTaskScreen()),
          );
          
        },
        child: Icon(Icons.create),
      ),
    );
  }
}
