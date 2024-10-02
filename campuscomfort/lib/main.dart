import 'package:campuscomfort/map_sample.dart';
import 'package:campuscomfort/map_tab.dart';
import 'package:campuscomfort/my_reviews_tab.dart';
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
    return DefaultTabController(
        length: 2,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: const Text('Campus Comfort'),
                    centerTitle: true,
                    bottom: const TabBar(tabs: [
                      Tab(text: 'Map'),
                      Tab(text: 'My Reviews'),
                    ])),
                body: const TabBarView(children: [
                  MapTab(),
                  MyReviewsTab(),
                ]))));
  }
}
