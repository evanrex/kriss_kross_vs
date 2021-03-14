import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';
import 'package:kriss_kross_vs/screens/home/booking.dart';

class etaTile extends StatelessWidget {
  final Location location;

  const etaTile({Key key, this.location}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            leading: Icon(Icons.location_on),
            title: Text(location.name),
            subtitle: Text('(' +
                location.geoPoint.latitude.toString() +
                ',' +
                location.geoPoint.longitude.toString() +
                ')'),
            onTap: () {
              print(location.name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Booking(location: location)));
            }),
      ),
    );
  }
}
