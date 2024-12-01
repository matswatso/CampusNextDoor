import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/material.dart';

class BuildingReview extends Review {
  final int accessibilityStars;
  final int navigabilityStars;

  BuildingReview({
    required super.id,
    required super.userId,
    required super.starRating,
    required super.reviewText,
    required super.title,
    required super.buildingName,
    required super.image,
    required super.dateReviewed,
    required this.accessibilityStars,
    required this.navigabilityStars,
  });

  @override
  String get reviewTypeName => 'Building';

  @override
  String get reviewedItemName => buildingName;

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
        buildRatingRow("Accessibility", accessibilityStars),
        const SizedBox(height: 4),
        buildRatingRow("Navigability", navigabilityStars),
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
      'imageUrl': image,
      'dateReviewed': dateReviewed.toIso8601String(),
      'buildingName': buildingName,
      'accessibilityStars': accessibilityStars,
      'navigabilityStars': navigabilityStars,
    };
  }

  factory BuildingReview.fromMap(Map<String, dynamic> map) {
    return BuildingReview(
      id: map['id'],
      userId: map['userId'],
      starRating: map['starRating'],
      reviewText: map['reviewText'],
      title: map['title'],
      image: map['imageUrl'],
      dateReviewed: DateTime.parse(map['dateReviewed']),
      buildingName: map['buildingName'],
      accessibilityStars: map['accessibilityStars'],
      navigabilityStars: map['navigabilityStars'],
    );
  }
}
