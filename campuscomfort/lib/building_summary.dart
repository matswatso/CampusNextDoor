import 'package:campuscomfort/geofencing_service.dart';
import 'package:campuscomfort/map_sample.dart';
import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/material.dart';

class BuildingSummary extends StatelessWidget {
  final List<Review> reviews;
  final GlobalKey<MapSampleState> mapSampleKey;
  final UMDBuilding building;

  const BuildingSummary({
    super.key,
    required this.reviews,
    required this.mapSampleKey,
    required this.building,
  });

  double _calculateAverageStars(List<Review> reviews) {
    if (reviews.isEmpty) return 0.0;
    final sum = reviews.fold(0, (sum, review) => sum + review.starRating);
    return sum / reviews.length;
  }

  List<Widget> _buildStarRow(double rating) {
    return [
      ...List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber);
        } else if (index == rating.floor() && rating % 1 > 0) {
          return const Icon(Icons.star_half, color: Colors.amber);
        }
        return const Icon(Icons.star_border, color: Colors.amber);
      }),
      const SizedBox(width: 8),
      Text(
        rating.toStringAsFixed(1),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buildReviewSection(String title, double averageStars) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(children: _buildStarRow(averageStars)),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    final reviewsWithImages = reviews
        .where((review) => review.image != null)
        .take(6)
        .toList();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Photos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (reviewsWithImages.isEmpty)
              const Center(
                child: Text(
                  'No photos available',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: reviewsWithImages
                    .map((review) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            review.image!,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    final totalReviews = reviews.length;
    final recentReviews = reviews
        .where((review) => 
            DateTime.now().difference(review.dateReviewed).inDays < 30)
        .length;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Stats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Total Reviews', totalReviews.toString()),
                _buildStat('Recent Reviews', recentReviews.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationReviews = reviews.whereType<BuildingReview>().toList();
    final amenityReviews = reviews.where((r) => r is! BuildingReview).toList();
    
    final locationAverage = _calculateAverageStars(locationReviews);
    final amenityAverage = _calculateAverageStars(amenityReviews);

    return Scaffold(
      appBar: AppBar(
        title: Text('${building.officialName} Summary'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildReviewSection('Location Rating', locationAverage),
              _buildReviewSection('Amenity Rating', amenityAverage),
              _buildQuickStats(),
              _buildImageGallery(),
            ],
          ),
        ),
      ),
    );
  }
}