import 'package:campuscomfort/reviews/review.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiscellaneousReview extends Review with LocationMixin {
  final String objectReviewed; // Max length: 32 characters

  MiscellaneousReview({
    required super.id,
    required super.userId,
    required super.starRating,
    required super.reviewText,
    required super.title,
    required super.imageUrl,
    required super.dateReviewed,
    required this.objectReviewed,
    required LatLng location,
  }) : assert(objectReviewed.length <= 32) {
    this.location = location;
  }

  @override
  String get reviewTypeName => 'Misc';

  @override
  String get reviewedItemName => objectReviewed;

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
      'imageUrl': imageUrl,
      'dateReviewed': dateReviewed.toIso8601String(),
      'objectReviewed': objectReviewed,
      'location': {'latitude': location.latitude, 'longitude': location.longitude},
    };
  }

  factory MiscellaneousReview.fromMap(Map<String, dynamic> map) {
    return MiscellaneousReview(
      id: map['id'],
      userId: map['userId'],
      starRating: map['starRating'],
      reviewText: map['reviewText'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      dateReviewed: DateTime.parse(map['dateReviewed']),
      objectReviewed: map['objectReviewed'],
      location: LatLng(map['location']['latitude'], map['location']['longitude']),
    );
  }
}
