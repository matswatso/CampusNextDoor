import 'dart:math';

import 'package:campuscomfort/map_sample.dart';
import 'package:campuscomfort/my_reviews_tab.dart';
import 'package:campuscomfort/reviews/bathroom_review.dart';
import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/cafe_review.dart';
import 'package:campuscomfort/reviews/miscellaneous_review.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:campuscomfort/reviews/study_area_review.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatelessWidget {
  final List<Review> reviews;
  final GlobalKey<MapSampleState> mapSampleKey;

  const MapTab({
    super.key,
    required this.reviews,
    required this.mapSampleKey,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Center(child: LayoutBuilder(builder: (context, constraints) {
        return orientation == Orientation.portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SuggestionsView(
                            reviews: reviews,
                            mapSampleKey: mapSampleKey,
                          ),
                        ),
                      );
                    },
                    child: const Text('Suggested Locations'),
                  ),
                    Expanded(child: MapSample(key: mapSampleKey, reviews: reviews)),
                  ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SuggestionsView(
                            reviews: reviews,
                            mapSampleKey: mapSampleKey,
                          ),
                        ),
                      );
                    },
                    child: const Text('Suggested Locations'),
                  ),
                  Expanded(child: MapSample(key: mapSampleKey, reviews: reviews)),
                ],
              );
      }));
    });
  }

  
}

class SuggestionsView extends StatelessWidget {
  final List<Review> reviews;
  final GlobalKey<MapSampleState> mapSampleKey;

  const SuggestionsView({
    super.key,
    required this.reviews,
    required this.mapSampleKey,
  });

  List<Review> _getSuggestedLocations() {
    // Lists to contain Review subclasses
    final List<BathroomReview> bathroomReviews = [];
    final List<BuildingReview> buildingReviews = [];
    final List<CafeReview> cafeReviews = [];
    final List<MiscellaneousReview> miscReviews = [];
    final List<StudyAreaReview> studyAreaReviews = [];

    for (var review in reviews) { // Fill lists
      if (review is BathroomReview) {
        bathroomReviews.add(review);
      } else if (review is BuildingReview) {
        buildingReviews.add(review);
      } else if (review is CafeReview) {
        cafeReviews.add(review);
      } else if (review is MiscellaneousReview) {
        miscReviews.add(review);
      } else if (review is StudyAreaReview) {
        studyAreaReviews.add(review);
      }
    }

    final userLocation = mapSampleKey.currentState?.currentPosition ?? const LatLng(38.989571,-76.936436);

    Review? getSuggestedReview(List<Review> reviewList) {
      if (reviewList.isEmpty) return null;
      
      // Special case for BuildingReview which does not have LocationMixin
      if (reviewList.first is BuildingReview) {
        return reviewList.first; // May be null
      }

      // For other review types (which do have LocationMixin)
      final reviewsWithDistance = reviewList.map((review) {
        final locationReview = review as LocationMixin;
        final distance = _calculateDistance(userLocation, locationReview.location);
        return {'review': review, 'distance': distance};
      }).where((item) => (item['distance'] as double) <= 200) // Filter reviews within 200m. item will never be null, that would be filtered out before this point
          .toList();

      // Sort by distance and take top 3
      reviewsWithDistance.sort((a, b) => (a['distance'] as double).compareTo(b['distance'] as double)); // passsing custom compareTo() for sorting the map
      final nearestThree = reviewsWithDistance.take(3).toList();

      if (nearestThree.isEmpty) return null;

      // Find highest rated among nearest three
      return nearestThree.reduce((curr, next) {
        final currReview = curr['review'] as Review;
        final nextReview = next['review'] as Review;
        return currReview.starRating > nextReview.starRating ? curr : next;
      })['review'] as Review;
    }

    // get each suggestion
    final suggestions = [
      getSuggestedReview(bathroomReviews),
      getSuggestedReview(buildingReviews),
      getSuggestedReview(cafeReviews),
      getSuggestedReview(miscReviews),
      getSuggestedReview(studyAreaReviews),
    ].whereType<Review>().toList(); // toList() removes null values

    return suggestions;
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

  String _getReviewType(Review review) {
    if (review is BathroomReview) return 'Bathroom';
    if (review is BuildingReview) return 'Building';
    if (review is CafeReview) return 'Cafe';
    if (review is StudyAreaReview) return 'Study Area';
    if (review is MiscellaneousReview) return review.objectReviewed;
    return 'Unknown'; // Incase we add more review types in the future or something. idk, it has to be here
  }

  @override
  Widget build(BuildContext context) {
    final suggestedReviews = _getSuggestedLocations(); // get suggestions

    return Scaffold(
      appBar: AppBar(title: const Text('Suggested Locations')),
      body: ListView.builder(
        itemCount: suggestedReviews.length,
        itemBuilder: (context, index) {
          final review = suggestedReviews[index];
          return ListTile(
            leading: review.image != null
                ? Image.file(review.image!)
                : const Icon(Icons.rate_review),
            title: Text(_getReviewType(review)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    review.starRating,
                    (index) =>
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                  ),
                ),
                Text(review.title),
              ],
            ),
            trailing: Text(review.dateReviewed.toString().split(' ')[0]),
            onTap: () { // This just shows the review for now. Could be replaced with directions or something
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const ReviewView(),
                  settings: RouteSettings(arguments: review),
                ),
              );
            },
          );
        },
      ),
    );
  }
}