import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/screens/home/location_tile.dart';
import 'package:provider/provider.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<List<Location>>(context) ?? [];
    locations.forEach((location) {
      print(location.name);
      print(location.geoPoint);
    });

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (conext, index) {
        return LocationTile(location: locations[index]);
      },
    );
  }
}
