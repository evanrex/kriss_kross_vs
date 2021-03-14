import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';
import 'package:kriss_kross_vs/screens/home/location_tile.dart';
import 'package:provider/provider.dart';

class ETA extends StatefulWidget {
  @override
  _ETAState createState() => _ETAState();
}

class _ETAState extends State<ETA> {
  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<List<Location>>(context) ?? [];
    locations.forEach((location) {});

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (conext, index) {
        return LocationTile(location: locations[index]);
      },
    );
  }
}
