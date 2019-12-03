import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:job_bazaar/models/task.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoom = 5.0;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tasks').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text("Loading...");

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: () {},
            ),
            title: Text("Copenhagen"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              _googleMap(context, snapshot.data.documents),
              _tasksContainer()
              //zoominsfunction
            ],
          ),
        );
      },
    );
  }

  Widget _tasksContainer() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(55.6802303, 12.5702209, "KU"),
            )
          ],
        ),
      ),
    );
  }

  Widget _boxes(double lat, double long, String taskLocation) {
    return GestureDetector(
      onTap: () {
        _goToTasksLocation(lat, long);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: myDetailsContainer(taskLocation),
        ),
      ),
    );
  }

  Widget myDetailsContainer(String tasksInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(tasksInfo,
                style: TextStyle(
                    color: (Colors.black54),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }

  Widget _googleMap(
      BuildContext context, List<DocumentSnapshot> documents) {
    final markers = documents.map((doc) => Task.fromMap(doc.data)).map((doc) => Marker(
          markerId: MarkerId(doc.placeId),
          position: LatLng(doc.latitude, doc.longitude),
          infoWindow: InfoWindow(title: doc.title),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        )).toSet();

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(55.676098, 12.568337), zoom: 10),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
  }

  Future<void> _goToTasksLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: 15, tilt: 50.0, bearing: 45.0)));
  }
}
