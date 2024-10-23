import 'dart:async';
import 'dart:math';

import 'package:campuscomfort/my_reviews_tab.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSample extends StatefulWidget {
  final List<Review> reviews;

  const MapSample({
    super.key,
    required this.reviews
  });

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Location _location = Location();
  LatLng _currentPosition = const LatLng(0, 0); // Will need to access this for adding reviews and suggestions
  StreamSubscription<LocationData>? _locationSubscription; // Real time location tracking

  // For use in main.dart when making Reviews
  LatLng? get currentPosition => _currentPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _initializeMarkers();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    final status = await Permission.locationWhenInUse.request(); // Wait for permissions
    
    if (status.isGranted) {
      _location.changeSettings(interval: 10000, distanceFilter: 5); // Update every 10 seconds or 5 meters

      // Create variable to track location data
      _locationSubscription = _location.onLocationChanged.listen((LocationData locationData) async {
        final newPosition = LatLng(locationData.latitude!, locationData.longitude!);
        setState(() { // setState() so it updates. Updating _currentPosition for use elsewhere
          _currentPosition = newPosition;
        });

        // From terpiez project, can put other things to be updated here
        // _updateClosestTerpieDistance();

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(newPosition));
      });
    } else if (status.isDenied) { // TODO: Maybe remove this?
      // Handle denied permission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is required to show your location on the map.')),
      );
    } else if (status.isPermanentlyDenied) {
      // Handle permanently denied permission
      openAppSettings();
    }
  }

  // This is a set of markers to be on the map. For now, just reviews
  Set<Marker> _markers = {};

  // initialize review markers
  void _initializeMarkers() {
    _markers = widget.reviews.where((review) {
      return review is LocationMixin; // Only place markers for reviews with locations. TODO: Add points on buildings for BuildingReviews
    }).map((review) {
      final locationReview = review as LocationMixin; // To be able to access location
      return Marker(
        markerId: MarkerId(review.id.toString()),
        position: locationReview.location,
        infoWindow: InfoWindow(
          title: review.reviewedItemName,
        ),
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ReviewView(),
                      settings: RouteSettings(arguments: review)));
        },
      );
    }).toSet();
  }

  // Credit to https://www.geeksforgeeks.org/program-distance-two-points-earth/ for this function
  double _calculateDistance(LatLng start, LatLng end) {
    double lat1 = start.latitude * (pi / 180); // to radians
    double lat2 = end.latitude * (pi / 180);
    double lon1 = start.longitude * (pi / 180);
    double lon2 = end.longitude * (pi / 180);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = pow(sin(dLat / 2), 2)
        + cos(lat1) * cos(lat2)
        * pow(sin(dLon / 2), 2);

    double c = 2 * asin(sqrt(a));

    const int r = 6371000; // in meters

    return r * c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: _currentPosition, // Go to user
          zoom:18,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers, // Places reviews
      ),
      // I am keeping this here as reference for suggestions in milestone 3
      /*
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
      */
    );
  }

  // I am keeping this here as reference for suggestions in milestone 3
  /*
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kUMD));
  }
  */
}