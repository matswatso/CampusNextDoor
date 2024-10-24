import 'dart:io';

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
            title: Text(review.reviewedItemName),
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
                Text(review.title),
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
      body: OrientationBuilder(builder: (context, orientation) {
        return Center(child: LayoutBuilder(builder: (context, constraints) {
          return orientation == Orientation.portrait
              ? Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(review.userId, style: const TextStyle(fontSize: 20)),
                          Text(review.title, style: const TextStyle(fontSize: 25)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              review.starRating,
                              (index) => const Icon(Icons.star,
                                  size: 26, color: Colors.amber),
                            ),
                          ),
                          Text(review.reviewText,
                              style: const TextStyle(fontSize: 18)),
                          if (review.image != null)
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(review.image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          review.buildRatings(), // Custom for each review type, shows extra star fields
                        ],
                      ),
                  ),
                ),
              )
              : Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(review.userId,
                                      style: const TextStyle(fontSize: 26)),
                                  Text(review.title,
                                      style: const TextStyle(fontSize: 26)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Expanded(
                                        child: Text(
                                      review.reviewText,
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                                  if (review.image != null) // TODO: placement for image
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(review.image!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Text("Overall: ",
                                      style: TextStyle(fontSize: 26)),
                                  ...List.generate(
                                    review.starRating,
                                    (index) => const Icon(Icons.star,
                                        size: 26, color: Colors.amber),
                                  ),
                                ],
                              ),
                              review.buildRatings(), // Custom for each review type, shows extra star fields
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
              );
        }));
      }),
    );
  }
}
