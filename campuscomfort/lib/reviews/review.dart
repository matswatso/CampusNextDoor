import 'dart:io';
import 'package:campuscomfort/reviews/bathroom_review.dart';
import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/cafe_review.dart';
import 'package:campuscomfort/reviews/miscellaneous_review.dart';
import 'package:campuscomfort/reviews/study_area_review.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Don't use this, use the subclasses. The subclasses are like this but a bit different
abstract class Review {
  // Review ID
  final String id;
  // User ID for the user who posted it.
  // Might not be used, idk
  final String userId;
  // Rating
  final int starRating;
  // The text of the review
  final String reviewText;
  // The title of the review
  final String title;
  // Image, though im not sure how to use this yet
  // Type File?, ? indicates it can be null. This is what we will use when the user does not upload an image
  final File? image;
  // Review Date
  final DateTime dateReviewed;

  Review({
    required this.id,
    required this.userId,
    required this.starRating,
    required this.reviewText,
    required this.title,
    required this.image,
    required this.dateReviewed,
  }) : assert(title.length <= 64);

  // Accessors (abstract, implemented in each review type)
  String get reviewTypeName;
  String get reviewedItemName;

  // Abstract class used to display the unique ratings of each subclass
  Widget buildRatings();
  
  Map<String, dynamic> toMap();
  
  // Used for persistence, but we aren't implementing that right now

  factory Review.fromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'Building':
        return BuildingReview.fromMap(map);
      case 'StudyArea':
        return StudyAreaReview.fromMap(map);
      case 'Bathroom':
        return BathroomReview.fromMap(map);
      case 'Cafe':
        return CafeReview.fromMap(map);
      case 'Miscellaneous':
        return MiscellaneousReview.fromMap(map);
      default:
        throw ArgumentError('Unknown review type: ${map['type']}');
    }
  }
}

// To prevent code duplication
// mixin is like multi inheritence except not
mixin LocationMixin {
  late final LatLng location;
}
