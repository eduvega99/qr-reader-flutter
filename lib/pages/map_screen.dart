import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_models.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition position = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50
    );

    // Marcador
    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('geolocation'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50
                  )
                )
              );
            }
          )
        ],
      ),
      body: GoogleMap(
        markers: markers,
        // myLocationButtonEnabled: true,
        mapType: this.mapType,
        initialCameraPosition: position,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed:  () {
          this.mapType = (mapType == MapType.normal) ? MapType.satellite : MapType.normal;
          setState(() {});
        },
      ),
   );
  }
}