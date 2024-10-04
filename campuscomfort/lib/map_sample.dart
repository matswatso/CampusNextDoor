import 'dart:async';

import 'package:campuscomfort/my_reviews_tab.dart';
import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kUMD = CameraPosition(
      bearing: 0,
      target: LatLng(38.9869, -76.9426),
      tilt: 0.0,
      zoom: 18);

  // This is a set of markers to be on the map. For now, just reviews
  Set<Marker> _markers = {};

  // initialize review markers
  void _createMarkers() {
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

  // So we only initialize markers once, we create them in the initialization
  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kUMD,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
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