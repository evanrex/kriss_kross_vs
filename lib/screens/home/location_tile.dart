import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  LocationTile({this.location});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(location.name),
          subtitle: Text('(' +
              location.geoPoint.latitude.toString() +
              ',' +
              location.geoPoint.longitude.toString() +
              ')'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ),
    );
  }
}
