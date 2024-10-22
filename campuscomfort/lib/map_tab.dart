import 'package:campuscomfort/map_sample.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:flutter/material.dart';

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
                    Expanded(child: MapSample(key: mapSampleKey, reviews: reviews)),
                    /*Padding( // Where other elements will go, if we need them
                      padding: EdgeInsets.all(8.0),
                      child: Text('Elements here'),
                    )*/
                  ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*Padding( // Where other elements will go, if we need them
                    padding: EdgeInsets.all(8.0),
                    child: Text('Elements here'),
                  ), */
                  Expanded(child: MapSample(key: mapSampleKey, reviews: reviews)),
                ],
              );
      }));
    });
  }
}
