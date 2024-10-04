import 'package:campuscomfort/map_sample.dart';
import 'package:campuscomfort/map_tab.dart';
import 'package:campuscomfort/my_reviews_tab.dart';
import 'package:campuscomfort/reviews/bathroom_review.dart';
import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/cafe_review.dart';
import 'package:campuscomfort/reviews/miscellaneous_review.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:campuscomfort/reviews/study_area_review.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Review> reviews = [
    BathroomReview(
        id: 'Bathroom1',
        userId: 'Andrew Tiananmen Zong',
        starRating: 4,
        reviewText: 'Clean, but a bit dark imo',
        title: 'Iribe First Floor',
        image: null,
        dateReviewed: DateTime(2024, 9, 22),
        location: const LatLng(38.9869, -76.9426),
        cleanlinessStars: 5,
        wellStockedStars: 3),
    BuildingReview(
        id: 'Iribe',
        userId: 'Andrew Tiananmen Zong',
        starRating: 5,
        reviewText:
            'Nice, but the elevator is very slow. Can be difficult to find rooms',
        title: 'One of the buildings of all time',
        image: null,
        dateReviewed: DateTime(2024, 9, 15),
        buildingName: 'Iribe Center for Computer Science',
        accessibilityStars: 5,
        navigabilityStars: 4),
    CafeReview(
        id: 'Taco Bell 1',
        userId: 'Andrew Tiananmen Zong',
        starRating: 2,
        reviewText:
            'I am a fun hating loser, so I dont like the enormous cheez-itz',
        title: 'I Hate Fun',
        image: null,
        dateReviewed: DateTime(2024, 10, 2),
        location: const LatLng(38.9880, -76.9410),
        cafeName: 'Taco Bell',
        customerServiceStars: 4,
        foodQualityStars: 3,
        cleanlinessStars: 4),
    MiscellaneousReview(
        id: 'NapPods',
        userId: 'Nap Pods Daily',
        starRating: 5,
        reviewText: 'These nap pods are a lifesaver during finals week!',
        title: 'Amazing nap pods in the library',
        image: null,
        dateReviewed: DateTime(2024, 10, 1),
        location: const LatLng(38.9865, -76.9430),
        objectReviewed: 'Nap Pods'),
    StudyAreaReview(
        id: 'Clarice1',
        userId: 'Alex Jorgensen',
        starRating: 4,
        reviewText:
            'Honestly I have no idea, Ive never studied there but the vibe is nice and its near a cafe',
        title: 'Honestly who goes to clarice tho',
        image: null,
        dateReviewed: DateTime(2023, 10, 5),
        location: const LatLng(38.9865, -76.940),
        studyAreaName: 'Clarice Study Area',
        noiseLevelStars: 5,
        comfortStars: 4,
        popularityStars: 2),
  ];

  void _showAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AddReviewForm(onSubmit: _addReview),
          ),
        );
      },
    );
  }

  void _addReview(Map<String, dynamic> reviewData) {
    setState(() {
      reviews.add(
        BathroomReview( // TODO: Dynamic review fields
          id: DateTime.now().toString(),
          userId: 'exampleUser',
          starRating: reviewData['starRating'].toInt(),
          reviewText: reviewData['description'],
          title: reviewData['areaName'], // TODO: enforce length limits
          image: reviewData['image'],
          dateReviewed: DateTime.now(),
          location: const LatLng(38.9869, -76.9426), 
          cleanlinessStars: 5, 
          wellStockedStars: 3, 
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Campus Comfort'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(text: 'Map'),
              Tab(text: 'My Reviews'),
            ]),
          ),
          body: TabBarView(children: [
            const MapTab(),
            MyReviewsTab(reviews: reviews),
          ]),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddReviewDialog(context),
            label: const Text('Add Review'),
            icon: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        ),
      ),
    );
  }
}

class AddReviewForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  AddReviewForm({required this.onSubmit});

  @override
  _AddReviewFormState createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _formKey = GlobalKey<FormState>();
  String _areaName = '';
  String _reviewType = 'Bathroom';
  double _starRating = 0;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Area Name'),
              onSaved: (value) {
                _areaName = value!;
              },
            ),
            DropdownButtonFormField<String>(
              value: _reviewType,
              items: ['Building', 'Bathroom', 'Cafe', 'Miscellaneous', 'Study Area', 'Water Fountain']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _reviewType = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Review Type'),
            ),
            const SizedBox(height: 16),
            const Text('* Star Rating *'),
            Slider(
              value: _starRating,
              onChanged: (value) {
                setState(() {
                  _starRating = value;
                });
              },
              min: 0,
              max: 5,
              divisions: 5,
              label: _starRating.round().toString(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              onSaved: (value) {
                _description = value!;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSubmit({
                    'areaName': _areaName,
                    'reviewType': _reviewType,
                    'starRating': _starRating,
                    'description': _description,
                    'image': null, // just for noew
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
