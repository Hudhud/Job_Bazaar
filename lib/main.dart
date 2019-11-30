import 'package:flutter/material.dart';
import 'home_page.dart';
import './tasks_page.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    HomePage(),
    TasksPage(),
    Text('My profile'), // add the my profile class here.
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.black87,
        buttonTheme: ButtonThemeData(buttonColor: Colors.orange),
      ),
      home: Scaffold(
        //appBar: AppBar(backgroundColor: Colors.black54,),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          selectedFontSize: 20,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
              ),
              title: Text("Tasks"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group_work,
              ),
              title: Text("My Tasks"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.view_stream,
              ),
              title: Text("Profile"),
              backgroundColor: (Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
