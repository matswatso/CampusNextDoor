import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CafeReview extends Review with LocationMixin {
  final String cafeName;
  final int customerServiceStars;
  final int foodQualityStars;
  final int cleanlinessStars;

  CafeReview({
    required super.id,
    required super.userId,
    required super.starRating,
    required super.reviewText,
    required super.title,
    required super.buildingName,
    required super.image,
    required super.dateReviewed,
    required this.cafeName,
    required this.customerServiceStars,
    required this.foodQualityStars,
    required this.cleanlinessStars,
    required LatLng location,
  }) {
    this.location = location;
  }

  @override
  String get reviewTypeName => 'Cafe';

  @override
  String get reviewedItemName => cafeName;

  @override
  Widget buildRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detailed Ratings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        buildRatingRow("Food Quality", foodQualityStars),
        const SizedBox(height: 4),
        buildRatingRow("Cleanliness", cleanlinessStars),
      ],
    );
  }

  // The below 2 functions are used to store and read this object for persistence
  // We are not implementing persistence yet, but we will, so they are here

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'Building',
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
      'cafeName': cafeName,
      'customerServiceStars': customerServiceStars,
      'foodQualityStars': foodQualityStars,
      'cleanlinessStars': cleanlinessStars,
    };
  }

  factory CafeReview.fromMap(Map<String, dynamic> map) {
    return CafeReview(
      id: map['id'],
      userId: map['userId'],
      starRating: map['starRating'],
      reviewText: map['reviewText'],
      title: map['title'],
      buildingName: map['buildingName'],
      image: map['imageUrl'],
      dateReviewed: DateTime.parse(map['dateReviewed']),
      cafeName: map['cafeName'],
      customerServiceStars: map['customerServiceStars'],
      foodQualityStars: map['foodQualityStars'],
      cleanlinessStars: map['cleanlinessStars'],
      location:
          LatLng(map['location']['latitude'], map['location']['longitude']),
    );
  }
}
