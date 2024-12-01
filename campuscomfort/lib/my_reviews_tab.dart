import 'dart:io';

import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/miscellaneous_review.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/material.dart';

class MyReviewsTab extends StatelessWidget {
  final List<Review> reviews;

  MyReviewsTab({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ListTile(
            leading: review.image != null
                ? Image.file(review.image!)
                : const Icon(Icons.rate_review),
            title: Text(review.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    // Generate 1 star for every star in the rating
                    review.starRating,
                    (index) =>
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                  ),
                ),
                Text(review.reviewedItemName),
              ],
            ),
            trailing: Text(review.dateReviewed.toString().split(' ')[0]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ReviewView(),
                      settings: RouteSettings(arguments: reviews[index])));
            });
      },
    );
  }
}

class ReviewView extends StatelessWidget {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final Review review = ModalRoute.of(context)!.settings.arguments as Review;

    return Scaffold(
      appBar: AppBar(
        title: Text(review.reviewedItemName),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            heightFactor: 1.0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: orientation == Orientation.portrait
                    ? _buildPortraitLayout(review)
                    : _buildLandscapeLayout(review),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPortraitLayout(Review review) {
    return Column(
      children: [
        _buildHeaderCard(review),
        const SizedBox(height: 16),
        _buildOverallRatingCard(review.starRating),
        const SizedBox(height: 16),
        if (review is! MiscellaneousReview) ...[
          _buildDetailedRatingsCard(review),
          const SizedBox(height: 16),
        ],
        _buildReviewTextCard(review),
        if (review.image != null) ...[
          const SizedBox(height: 16),
          _buildImageCard(review),
        ],
      ],
    );
  }

  Widget _buildLandscapeLayout(Review review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ // Split into columns
        Expanded( // Left
          flex: 3,
          child: Column(
            children: [
              _buildHeaderCard(review),
              const SizedBox(height: 16),
              _buildReviewTextCard(review),
              if (review.image != null) ...[
                const SizedBox(height: 16),
                _buildImageCard(review),
              ],
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded( // right
          flex: 2,
          child: Column(
            children: [
              _buildOverallRatingCard(review.starRating),
              const SizedBox(height: 16),
              _buildDetailedRatingsCard(review),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCard(Review review) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (review is! BuildingReview)
              Text(
                "Building: ${review.buildingName}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            if (review is! BuildingReview) const SizedBox(height: 8),
            Text(
              review.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Reviewed by ${review.userId}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallRatingCard(int stars) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overall Rating',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                stars,
                (index) => const Icon(
                  Icons.star,
                  size: 32,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedRatingsCard(Review review) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: review.buildRatings(),
      ),
    );
  }

  Widget _buildReviewTextCard(Review review) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              review.reviewText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(Review review) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Review Image',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            child: Image.file(
              File(review.image!.path),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
