import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/material.dart';
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
    required super.image,
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

  @override
  Widget buildRatings() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              const Text("Noise Level: ", style: TextStyle(fontSize: 26)),
              ...List.generate(
                noiseLevelStars,
                (index) => const Icon(Icons.star, size: 26, color: Colors.amber),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Comfort: ", style: TextStyle(fontSize: 26)),
              ...List.generate(
                comfortStars,
                (index) => const Icon(Icons.star, size: 26, color: Colors.amber),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Popularity: ", style: TextStyle(fontSize: 26)),
              ...List.generate(
                popularityStars,
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
      'imageUrl': image,
      'dateReviewed': dateReviewed.toIso8601String(),
      'studyAreaName': studyAreaName,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude
      },
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
      image: map['imageUrl'],
      dateReviewed: DateTime.parse(map['dateReviewed']),
      studyAreaName: map['studyAreaName'],
      location:
          LatLng(map['location']['latitude'], map['location']['longitude']),
      noiseLevelStars: map['noiseLevelStars'],
      comfortStars: map['comfortStars'],
      popularityStars: map['popularityStars'],
    );
  }
}
