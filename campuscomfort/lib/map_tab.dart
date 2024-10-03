import 'package:campuscomfort/map_sample.dart';
import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Center(child: LayoutBuilder(builder: (context, constraints) {
        return orientation == Orientation.portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    //Expanded(child: MapSample()),
                    Expanded(
                        child: Icon(
                      Icons.cloud,
                      size: constraints.biggest.shortestSide,
                    )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Elements here'),
                    )
                  ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Elements here'),
                  ),
                  //Expanded(child: MapSample()),
                  Expanded(
                      child: Icon(
                    Icons.cloud,
                    size: constraints.biggest.shortestSide,
                  )),
                ],
              );
      }));
    });
  }
}
