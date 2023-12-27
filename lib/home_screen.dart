import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  late GoogleMapController googleMapController;
  LocationData? currentLocation;

  Future<void> getLocation() async {
    currentLocation = await location.getLocation();
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            currentLocation?.latitude! ?? 23.90604480483824,
            currentLocation?.longitude! ?? 90.219439061742,
          ),
          zoom: 17,
        ),
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          zoom: 15,
          bearing: 0,
          tilt: 10,
          target: LatLng(23.90604480483824, 90.219439061742),
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          getLocation();
        },
        onTap: (LatLng position) {
          print(position);
        },
        onLongPress: (LatLng position) {
          print(position);
        },
        onCameraMove: (position) {
          print(position.target);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        compassEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
              markerId: const MarkerId("marker1"),
              position: LatLng(
                23.90604480483824,
                90.219439061742,
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: const InfoWindow(
                title: "My Location",
                snippet: "subtitle here",
              ),
              draggable: true,
              onDrag: (LatLng position) {
                print("Value on dragging");
                print(position);
              },
              onDragStart: (LatLng position) {
                print("on drag start");
                print(position);
              },
              onDragEnd: (LatLng position) {
                print("on drag end");
                print(position);
              },
              onTap: () {
                print("you have tapped on marker");
              }),
          Marker(
              markerId: const MarkerId("marker2"),
              position: const LatLng(23.892967501242342, 90.2087214589119),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: const InfoWindow(
                title: "My Location",
                snippet: "subtitle here",
              ),
              draggable: true,
              onDrag: (LatLng position) {
                print("Value on dragging");
                print(position);
              },
              onDragStart: (LatLng position) {
                print("on drag start");
                print(position);
              },
              onDragEnd: (LatLng position) {
                print("on drag end");
                print(position);
              },
              onTap: () {
                print("you have tapped on marker");
              }),
        },
        polylines: {
          const Polyline(
            polylineId: PolylineId("poly-line-1"),
            color: Colors.red,
            width: 4,
            visible: true,
            patterns: [
              // PatternItem.gap(10),
              // PatternItem.dash(10),
              // PatternItem.dot,
            ],
            points: [
              LatLng(23.90604480483824, 90.219439061742),
              LatLng(23.892967501242342, 90.2087214589119)
            ],
          )
        },
        polygons: {
          Polygon(
            polygonId: PolygonId('polygon'),
            fillColor: Colors.green.shade400,
            strokeColor: Colors.green,
            strokeWidth: 4,
            consumeTapEvents: true,
            onTap: () {
              print("Polygon Shape Tapped");
            },
            points: [
              LatLng(23.912809504072616, 90.21282020956278),
              LatLng(23.90806943872789, 90.2071925997734),
              LatLng(23.901568232257848, 90.21107912063599),
              LatLng(23.907121404796474, 90.21700713783503),
            ],
          ),
        },
        circles: {
          Circle(
              circleId: CircleId('circle1'),
              fillColor: Colors.redAccent,
              strokeWidth: 4,
              strokeColor: Colors.red,
              center: LatLng(23.914650312838408, 90.2043229714036),
              radius: 500,
              consumeTapEvents: true,
              onTap: () {
                print("Circle Tapped");
              }),
        },
      ),
    );
  }
}