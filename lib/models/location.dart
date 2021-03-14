import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String name;
  final GeoPoint geoPoint;
  final List<dynamic> arrivalTime;
  final List<dynamic> pickUpLocations;
  final Map travelTimes;

  Location(
      {this.name,
      this.geoPoint,
      this.arrivalTime,
      this.pickUpLocations,
      this.travelTimes});
}
