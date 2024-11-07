import 'package:campuscomfort/building_summary.dart';
import 'package:campuscomfort/geofencing_service.dart';
import 'package:campuscomfort/map_sample.dart';
import 'package:campuscomfort/reviews/review.dart';
import 'package:campuscomfort/suggestions_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatelessWidget {
  final List<Review> reviews;
  final GlobalKey<MapSampleState> mapSampleKey;
  final GeofencingService geofencingService;

  const MapTab({
    super.key,
    required this.reviews,
    required this.mapSampleKey,
    required this.geofencingService
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Center(child: LayoutBuilder(builder: (context, constraints) {
        return orientation == Orientation.portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 12,
                              ),
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
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: buildSummaryButton(
                              reviews: reviews,
                              mapSampleKey: mapSampleKey,
                              context: context,
                              geofencingService: geofencingService,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: MapSample(key: mapSampleKey, reviews: reviews)),
                  ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 12,
                            ),
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
                        ),
                        buildSummaryButton(
                          reviews: reviews,
                          mapSampleKey: mapSampleKey,
                          context: context,
                          geofencingService: geofencingService,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: MapSample(key: mapSampleKey, reviews: reviews)),
                ],
              );
      }));
    });
  }
}

Widget buildSummaryButton({
  required List<Review> reviews,
  required GlobalKey<MapSampleState> mapSampleKey,
  required BuildContext context,
  required GeofencingService geofencingService,
}) {
  final currentPosition = mapSampleKey.currentState?.currentPosition ?? 
      const LatLng(38.989571, -76.936436);
      
  final currentBuilding = geofencingService.getCurrentBuilding(currentPosition);
  final bool isInBuilding = currentBuilding != null;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: isInBuilding 
          ? Theme.of(context).colorScheme.inversePrimary
          : Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: isInBuilding ? 12 : 0,
    ),
    onPressed: isInBuilding 
        ? () { // If we are in a building, open the view
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BuildingSummary(
                  reviews: reviews
                      .where((review) => currentBuilding.nameMatches(review.buildingName))
                      .toList(),
                  mapSampleKey: mapSampleKey,
                  building: currentBuilding,
                ),
              ),
            );
          }
        : null, // If we are not in a building, do nothing
    child: Text(
      'Building Summary',
      style: TextStyle(
        color: isInBuilding 
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      ),
    ),
  );
}