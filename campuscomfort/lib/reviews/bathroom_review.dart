import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BathroomReview extends Review with LocationMixin {
  final int cleanlinessStars;
  final int wellStockedStars;

  BathroomReview({
    required super.id,
    required super.userId,
    required super.starRating,
    required super.reviewText,
    required super.title,
    required super.buildingName,
    required super.image,
    required super.dateReviewed,
    required LatLng location,
    required this.cleanlinessStars,
    required this.wellStockedStars,
  }) {
    this.location = location;
  }

  @override
  String get reviewTypeName => 'Bathroom';

  @override
  String get reviewedItemName => 'Bathroom';

  @override
  Widget buildRatings() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              const Text("Cleanliness: ", style: TextStyle(fontSize: 26)),
              ...List.generate(
                cleanlinessStars,
                (index) => const Icon(Icons.star, size: 26, color: Colors.amber),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Stocked: ", style: TextStyle(fontSize: 26)),
              ...List.generate(
                wellStockedStars,
                (index) => const Icon(Icons.star, size: 26, color: Colors.amber),
              ),
            ],
          ),
        ]);
  }

  // The below 2 functions are used to store and read this object for persistence
  // We are not implementing persistence yet, but we will, so they are here

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'StudyArea',
      'id': id,
      'userId': userId,
      'starRating': starRating,
      'reviewText': reviewText,
      'title': title,
      'buildingName': buildingName,
      'imageUrl': image,
      'dateReviewed': dateReviewed.toIso8601String(),
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude
      },
      'cleanlinessStars': cleanlinessStars,
      'wellStockedStars': wellStockedStars,
    };
  }

  factory BathroomReview.fromMap(Map<String, dynamic> map) {
    return BathroomReview(
      id: map['id'],
      userId: map['userId'],
      starRating: map['starRating'],
      reviewText: map['reviewText'],
      title: map['title'],
      buildingName: map['buildingName'],
      image: map['imageUrl'],
      dateReviewed: DateTime.parse(map['dateReviewed']),
      location:
          LatLng(map['location']['latitude'], map['location']['longitude']),
      cleanlinessStars: map['cleanlinessStars'],
      wellStockedStars: map['wellStockedStars'],
    );
  }
}
