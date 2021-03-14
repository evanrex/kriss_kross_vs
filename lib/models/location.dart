import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String name;
  final GeoPoint geoPoint;

  Location({this.name, this.geoPoint});
}
