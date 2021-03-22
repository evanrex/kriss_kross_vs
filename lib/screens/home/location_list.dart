import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';
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

    return Container(
      height: 275,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.brown[300],
        gradient: new LinearGradient(
          colors: [Colors.brown, Colors.pink],
        ),
        //border: Border.all(color: Colors.brown[400], width: 5),
        //boxShadow: [10.0],
      ),
      child: Column(
        children: [
          Text('Make a Booking: ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  //border: Border.all(width: 2, color: Colors.white),
                  ),
              height: 235.0,
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (conext, index) {
                  return LocationTile(location: locations[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
