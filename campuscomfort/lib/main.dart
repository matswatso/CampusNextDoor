import 'package:campuscomfort/map_sample.dart';
import 'package:campuscomfort/map_tab.dart';
import 'package:campuscomfort/my_reviews_tab.dart';
import 'package:campuscomfort/reviews/bathroom_review.dart';
import 'package:campuscomfort/reviews/building_review.dart';
import 'package:campuscomfort/reviews/cafe_review.dart';
import 'package:campuscomfort/reviews/miscellaneous_review.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:campuscomfort/reviews/study_area_review.dart';
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    // Example reviews
    List<Review> sampleReviews = [
      BathroomReview(
          id: 'Bathroom1',
          userId: 'Andrew Tiananmen Zong',
          starRating: 4,
          reviewText: 'Clean, but a bit dark imo',
          title: 'Iribe First Floor',
          image: null,
          dateReviewed: DateTime(2024, 9, 22),
          location: const LatLng(38.9869, -76.9426),
          qualityStars: 4,
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
              ])),
          body: TabBarView(children: [
            const MapTab(),
            MyReviewsTab(reviews: sampleReviews),
          ]),

          // floating button needs functionality. Can it have a pop up, rather than a new view?
          // Note: It might be easier to have each review subclass create its own widget for creating reviews of that type
          // That way, the layouts can differ dynamically
          // I am not sure how to do that, but its probably something along the lines of having a generic function in Review that the subclasses implement
          // the subclasses have the same general structure to their widgets, but with specialized fields depending on the type
          // Maybe have it display a drop down where you can select the review type, then below that is an empty space which is filled by the widget for that review type
          floatingActionButton: FloatingActionButton.extended(
             onPressed: () => _showAddReviewDialog(context),
            label: const Text('Add Review'),
            icon: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        )));
  }
}

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
          child: AddReviewForm(),
        ),
      );
    },
  );
}


class AddReviewForm extends StatefulWidget {
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
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
