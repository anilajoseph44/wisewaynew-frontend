import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_yt/models/placemodel.dart'; // Make sure to import your place model
import 'package:google_maps_yt/services/place_service.dart'; // Import your place service

class MapNew extends StatefulWidget {
  @override
  State<MapNew> createState() => _MapNewState();
}

class _MapNewState extends State<MapNew> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  location.Location _locationController = location.Location();
  double _currentHeading = 0.0;
  LatLng? _currentPosition;
  List<PlaceList> _places = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocationUpdates();
    _fetchPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          _buildGoogleMap(),
        ],
      ),
    );
  }

  Widget _buildGoogleMap() {
    return _isLoading || _currentPosition == null
        ? Center(child: CircularProgressIndicator())
        : GoogleMap(
      onMapCreated: ((GoogleMapController controller) => _mapController.complete(controller)),
      initialCameraPosition: CameraPosition(target: _currentPosition!, zoom: 13),
      markers: _buildMarkers(),
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
    );
  }

  void _getLocationUpdates() async {
    await _locationController.requestPermission();
    _locationController.onLocationChanged.listen((location.LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _currentHeading = currentLocation.heading ?? 0.0; // Store the current heading
          _cameraToPosition(_currentPosition!);
        });
      }
    });
  }


  void _fetchPlaces() {
    PlaceService.fetchPlaces().then((places) {
      setState(() {
        _places = places;
        _isLoading = false;
      });
      // Print the fetched places to the console
      print('Fetched Places:');
      for (PlaceList place in _places) {
        print('Place ID: ${place.id}, Name: ${place.name}');
      }
    }).catchError((error) {
      print('Error fetching places: $error');
      setState(() {
        _isLoading = false;
      });
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch places')));
    });
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    // Add markers for fetched places
    for (PlaceList place in _places) {
      markers.add(
        Marker(
          markerId: MarkerId(place.id),
          position: LatLng(place.location.coordinates[0], place.location.coordinates[1]),
          infoWindow: InfoWindow(title: place.name ?? ''),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow), // You can customize the marker icon here
        ),
      );
    }

    // Add marker for current position
    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: MarkerId('current_position'),
          position: _currentPosition!,
          infoWindow: InfoWindow(title: 'Current Position'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Customize the marker icon
        ),
      );
    }

    return markers;
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }
}
