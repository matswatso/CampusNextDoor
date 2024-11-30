import 'package:campuscomfort/add_review_form.dart';
import 'package:campuscomfort/geofencing_service.dart';
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
        buildingName: 'Iribe',
        image: null,
        dateReviewed: DateTime(2024, 9, 22),
        location: const LatLng(38.9869, -76.9426),
        cleanlinessStars: 5,
        wellStockedStars: 3),
    BathroomReview(
        id: 'Bathroom2',
        userId: 'Matt Watson',
        starRating: 2,
        reviewText: 'This bathroom is terrible ngl',
        title: 'Mckeldin First Floor',
        buildingName: 'Mckeldin',
        image: null,
        dateReviewed: DateTime(2024, 9, 22),
        location: const LatLng(38.9869, -76.9426),
        cleanlinessStars: 2,
        wellStockedStars: 1),
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
    BuildingReview(
        id: 'CSI',
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
      BuildingReview(
        id: 'Windtunnel',
        userId: 'Matt Watson',
        starRating: 2,
        reviewText:
            'Very drafty for some reason, all I can hear are echoes',
        title: 'WIndy',
        image: null,
        dateReviewed: DateTime(2024, 9, 25),
        buildingName: 'Wind Tunnel',
        accessibilityStars: 5,
        navigabilityStars: 4),
      BuildingReview(
        id: 'Williams',
        userId: 'Matt Watson',
        starRating: 3,
        reviewText:
            'Drafty in here ngl I dont really like it',
        title: 'AV',
        image: null,
        dateReviewed: DateTime(2024, 10, 3),
        buildingName: 'A.V. Williams',
        accessibilityStars: 5,
        navigabilityStars: 4),
     BuildingReview(
        id: 'ea1',
        userId: 'Matt Watson',
        starRating: 2,
        reviewText:
            'Theres too many engineers in here',
        title: 'EA SPORTS in the game',
        image: null,
        dateReviewed: DateTime(2024, 10, 3),
        buildingName: 'Engineering Annex',
        accessibilityStars: 3,
        navigabilityStars: 2),
     BuildingReview(
        id: 'eaer1',
        userId: 'Matt Watson',
        starRating: 3,
        reviewText:
            'This building is quite huge',
        title: 'ERF',
        image: null,
        dateReviewed: DateTime(2024, 10, 3),
        buildingName: 'Energy Research Facility',
        accessibilityStars: 4,
        navigabilityStars: 1),
     BuildingReview(
        id: 'Biomolecular',
        userId: 'Matt Watson',
        starRating: 4,
        reviewText:
            'This building is very interesting, equipment seems very expensive',
        title: 'BIO',
        image: null,
        dateReviewed: DateTime(2024, 10, 3),
        buildingName: 'Biomolecular Sciences Building',
        accessibilityStars: 4,
        navigabilityStars: 1),

    CafeReview(
        id: 'Taco Bell 1',
        userId: 'Andrew Tiananmen Zong',
        starRating: 2,
        reviewText:
            'I am a fun hating loser, so I dont like the enormous cheez-itz',
        title: 'I Hate Fun',
        buildingName: 'Taco Bell Building',
        image: null,
        dateReviewed: DateTime(2024, 10, 2),
        location: const LatLng(38.9880, -76.9410),
        cafeName: 'Taco Bell',
        customerServiceStars: 4,
        foodQualityStars: 3,
        cleanlinessStars: 4),


    CafeReview(
        id: 'Iribe 1',
        userId: 'Matt Watson',
        starRating: 4,
        reviewText:
            'This honestly is a decent cafe although they never have scones thats why they get 4 STARS',
        title: 'BreakPoint Cafe',
        buildingName: 'Iribe',
        image: null,
        dateReviewed: DateTime(2024, 10, 2),
        location: const LatLng(38.989165,-76.936354),
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
        buildingName: 'McKeldin Library',
        image: null,
        dateReviewed: DateTime(2024, 10, 1),
        location: const LatLng(38.9865, -76.9430),
        objectReviewed: 'Nap Pods'),

        MiscellaneousReview(
        id: 'Iribe Balcony',
        userId: 'Matt Watson',
        starRating: 5,
        reviewText: 'Genuinly an amazing view im so glad that I got the chance to see it',
        title: 'Iribe Top Balcony',
        buildingName: 'Iribe',
        image: null,
        dateReviewed: DateTime(2024, 10, 1),
        location: const LatLng(38.989079,-76.935875),
        objectReviewed: 'Balcony'),
    StudyAreaReview(
        id: 'Clarice1',
        userId: 'Alex Jorgensen',
        starRating: 4,
        reviewText:
            'Honestly I have no idea, Ive never studied there but the vibe is nice and its near a cafe',
        title: 'Honestly who goes to clarice tho',
        buildingName: 'Clarice Smith Performing Arts Center',
        image: null,
        dateReviewed: DateTime(2023, 10, 5),
        location: const LatLng(38.9865, -76.940),
        studyAreaName: 'Clarice Study Area',
        noiseLevelStars: 5,
        comfortStars: 4,
        popularityStars: 2),
  ];
  final mapKey = GlobalKey<MapSampleState>(); // allows us to access map state information

  // Functions for adding reviews
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
  // change this to just take a Review object and add it
  // or maybe not? needs location data which is easier to get here
  void _addReview(Map<String, dynamic> reviewData) {
    LatLng userLocation = mapKey.currentState?.currentPosition ?? const LatLng(38.989571,-76.936436);
    setState(() {
      switch (reviewData['type']) { // I think build map and call function given
        case 'Bathroom':
          reviews.add(
            BathroomReview(
              id: DateTime.now().toString(),
              userId: 'exampleUser',
              starRating: reviewData['starRating'].toInt(),
              reviewText: reviewData['reviewText'],
              title: reviewData['title'],
              buildingName: reviewData['buildingName'],
              image: reviewData['image'],
              dateReviewed: DateTime.now(),
              location: userLocation,
              cleanlinessStars: reviewData['cleanlinessStars'].toInt(), 
              wellStockedStars: reviewData['wellStockedStars'].toInt(), 
            )
          );
        case 'Building':
          reviews.add(
            BuildingReview(
              id: DateTime.now().toString(),
              userId: 'exampleUser',
              starRating: reviewData['starRating'].toInt(),
              reviewText: reviewData['reviewText'],
              title: reviewData['title'],
              buildingName: reviewData['buildingName'],
              image: reviewData['image'],
              dateReviewed: DateTime.now(),
              accessibilityStars: reviewData['accessibilityStars'].toInt(), 
              navigabilityStars: reviewData['navigabilityStars'].toInt(),
            )
          );
        case 'Cafe':
          reviews.add(
            CafeReview(
              id: DateTime.now().toString(),
              userId: 'exampleUser',
              starRating: reviewData['starRating'].toInt(),
              reviewText: reviewData['reviewText'],
              title: reviewData['title'],
              buildingName: reviewData['buildingName'],
              image: reviewData['image'],
              dateReviewed: DateTime.now(),
              cafeName: reviewData['cafeName'],
              customerServiceStars: reviewData['customerServiceStars'].toInt(),
              foodQualityStars: reviewData['foodQualityStars'].toInt(),
              cleanlinessStars: reviewData['cleanlinessStars'].toInt(),
              location: userLocation
            )
          );
        case 'Miscellaneous':
          reviews.add(
            MiscellaneousReview(
              id: DateTime.now().toString(),
              userId: 'exampleUser',
              starRating: reviewData['starRating'].toInt(),
              reviewText: reviewData['reviewText'],
              title: reviewData['title'],
              buildingName: reviewData['buildingName'],
              image: reviewData['image'],
              dateReviewed: DateTime.now(),
              objectReviewed: reviewData['objectReviewed'],
              location: userLocation
            )
          );
        case 'Study Area':
          reviews.add(
            StudyAreaReview(
              id: DateTime.now().toString(),
              userId: 'exampleUser',
              starRating: reviewData['starRating'].toInt(),
              reviewText: reviewData['reviewText'],
              title: reviewData['title'],
              buildingName: reviewData['buildingName'],
              image: reviewData['image'],
              dateReviewed: DateTime.now(),
              noiseLevelStars: reviewData['noiseLevelStars'].toInt(),
              comfortStars: reviewData['comfortStars'].toInt(),
              popularityStars: reviewData['popularityStars'].toInt(),
              studyAreaName: reviewData['studyAreaName'],
              location: userLocation
            )
          );
      }
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
              Tab(text: 'Reviews'),
            ]),
          ),
          body: TabBarView(children: [
            MapTab(reviews: reviews, mapSampleKey: mapKey, geofencingService: GeofencingService(),),
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