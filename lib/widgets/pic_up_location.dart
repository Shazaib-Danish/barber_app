import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickedUpLocation extends StatelessWidget {
  PickedUpLocation({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  final double latitude;
  final double longitude;
  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController _cntlr) {
    CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(latitude, longitude), zoom: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:
      CameraPosition(target: LatLng(latitude, longitude), zoom: 16),
      onMapCreated: _onMapCreated,
      markers: {
        Marker(markerId: const MarkerId('Home'),
            position: LatLng(latitude, longitude))
      },
      mapType: MapType.normal,
      myLocationEnabled: false,
    );;
  }
}

