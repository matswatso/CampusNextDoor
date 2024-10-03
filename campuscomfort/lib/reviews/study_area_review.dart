import 'package:campuscomfort/reviews/review.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StudyAreaReview extends Review with LocationMixin {
  final String studyAreaName;
  final int noiseLevelStars;
  final int comfortStars;
  final int popularityStars;

  StudyAreaReview({
    required super.id,
    required super.userId,
    required super.starRating,
    required super.reviewText,
    required super.title,
    required super.imageUrl,
    required super.dateReviewed,
    required this.studyAreaName,
    required LatLng location,
    required this.noiseLevelStars,
    required this.comfortStars,
    required this.popularityStars,
  }) {
    this.location = location;
  }

  @override
  String get reviewTypeName => 'Study Area';

  @override
  String get reviewedItemName => studyAreaName;

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
      'studyAreaName': studyAreaName,
      'location': {'latitude': location.latitude, 'longitude': location.longitude},
      'noiseLevelStars': noiseLevelStars,
      'comfortStars': comfortStars,
      'popularityStars': popularityStars,
    };
  }

  factory StudyAreaReview.fromMap(Map<String, dynamic> map) {
    return StudyAreaReview(
      id: map['id'],
      userId: map['userId'],
      starRating: map['starRating'],
      reviewText: map['reviewText'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      dateReviewed: DateTime.parse(map['dateReviewed']),
      studyAreaName: map['studyAreaName'],
      location: LatLng(map['location']['latitude'], map['location']['longitude']),
      noiseLevelStars: map['noiseLevelStars'],
      comfortStars: map['comfortStars'],
      popularityStars: map['popularityStars'],
    );
  }
}

