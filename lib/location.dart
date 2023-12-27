import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Location location = Location();
  LocationData? currentLocation;
  late StreamSubscription locationSubscription;
  LocationData? myLocation;

  void liveLocationDetect() {
    locationSubscription = location.onLocationChanged.listen((liveLocation) {
      myLocation = liveLocation;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    liveLocationDetect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${myLocation?.latitude.toString() ?? ''}, '
                  '${myLocation?.longitude.toString() ?? ''}',
            ),
            ElevatedButton(
              onPressed: () async {
                currentLocation = await location.getLocation();
                setState(() {});
              },
              child: const Text("Get My Location"),
            ),
            ElevatedButton(
              onPressed: () async {
                PermissionStatus status = await location.hasPermission();
                if (status == PermissionStatus.denied ||
                    status == PermissionStatus.deniedForever) {
                  await location.requestPermission();
                  currentLocation = await location.getLocation();
                }
              },
              child: Text("Ask Permission"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }
}