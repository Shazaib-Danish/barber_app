
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  final LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  late GoogleMapController _controller;
  Location _location = Location();

  Set<Marker> _markers={};

  //late BitmapDescriptor customIcon;

// make sure to initialize before map loading


  final nearbyCarsLocation = [
    LatLng(31.503708, 74.28093),
    LatLng(31.510189, 74.344084), //24.9294892,67.0391903,18.73z
  ];

  void _getNearByCars() {
    for (var i = 0; i < nearbyCarsLocation.length; i++) {
      var now = DateTime.now().millisecondsSinceEpoch;
      _markers.add(Marker(
          markerId: MarkerId(nearbyCarsLocation[i].toString() + now.toString()),
          position: nearbyCarsLocation[i],
          // infoWindow: InfoWindow(title: address, snippet: "go here"),
          ));
    }
  }


  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.single.then((l){
      _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 20),
              ),
            );
    });
    // _location.onLocationChanged.listen((l) {
    //   _controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 17),
    //     ),
    //   );
    //   setState(() {
    //     _markers.add(Marker(markerId: const MarkerId('Home'),
    //         position: LatLng(l.latitude ?? 0.0, l.longitude ?? 0.0)
    //     ));
    //   });
    // });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              markers: _markers,
            ),
            SlidingUpPanel(
              onPanelSlide: (value){

              },
              header: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                color: Colors.white,
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Finding near by Barbers')
                  ],
                ),
              ),
              panel: Center(
                child: Text(""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}