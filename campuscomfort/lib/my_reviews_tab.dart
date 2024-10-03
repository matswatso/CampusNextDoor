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
    // Add on tap functionality to open a pop up with additional details
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ListTile(
          leading: review.image != null
              ? Image.file(review.image!)
              : const Icon(Icons.rate_review),
          title: Text(review.reviewedItemName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate( // Generate 1 star for every star in the rating
                  review.starRating,
                  (index) => const Icon(Icons.star, size: 16),
                ),
              ),
              Text(review.title),
            ],
          ),
          trailing: Text(review.dateReviewed.toString().split(' ')[0]),
        );
      },
    );
  }
}
