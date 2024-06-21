import 'package:aquo/global.dart';
import 'package:aquo/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationMap extends StatefulWidget {
  const CurrentLocationMap({Key? key}) : super(key: key);

  @override
  State<CurrentLocationMap> createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  GoogleMapController? mapController;
  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 14.0,
  );
  Set<Marker> markers = {};

  final DatabaseServices _db = DatabaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Current Location'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        zoomControlsEnabled: false,
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            Position position = await _determinePosition();
            print(position);
            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14.0,
                ),
              ),
            );
            markers.clear();
            markers.add(
              Marker(
                markerId: const MarkerId('current location'),
                position: LatLng(position.latitude, position.longitude),
              ),
            );
            setState(() {});
            User? user = FirebaseAuth.instance.currentUser;
            isLocationSet = true;
            String uid = isGmailUser ? user!.uid : emailUID;
            await _db.setLocation(
              uid,
              position.longitude.toString(),
              position.latitude.toString(),
            );
            _showSetLocationDialog();
          } catch (e) {
            // Handle error
            print(e.toString());
            _showLocationServiceDialog();
          }
        },
        label: const Text(
          'Set location',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF5178F1),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw 'Location service is not enabled';
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw 'Location permission denied';
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Service Disabled"),
          content: const Text(
              "Please enable location services to use this feature."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSetLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Schedule a function to close the dialog after 2 seconds
        Future.delayed(Duration(seconds: 4), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        });
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.done,
            size: 50.0,
            //weight: 100,
            color: Colors.green.shade500,
          ),
          iconPadding: EdgeInsets.only(top: 10),
          title: Text(
            "Success !!",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: const Text(
            "Location is successfully set up.",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
