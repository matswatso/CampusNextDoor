import 'package:campuscomfort/reviews/bathroom_review.dart';
import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/cafe_review.dart';
import 'package:campuscomfort/reviews/miscellaneous_review.dart';
import 'package:campuscomfort/reviews/study_area_review.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Base Review class
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
  // Image? I don't remember how images are loaded
  final String? imageUrl;
  // Review Date
  final DateTime dateReviewed;

  Review({
    required this.id,
    required this.userId,
    required this.starRating,
    required this.reviewText,
    required this.title,
    required this.imageUrl,
    required this.dateReviewed,
  }) : assert(title.length <= 64);

  // Accessors (abstract, implemented in each review type)
  String get reviewTypeName;
  String get reviewedItemName;
  
  Map<String, dynamic> toMap();
  
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

mixin LocationMixin {
  late final LatLng location;
}
