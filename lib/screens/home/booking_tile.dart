import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/booking_model.dart';

class BookingTile extends StatelessWidget {
  final Booking booking;
  BookingTile({this.booking});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(Icons.location_on),
          title: Text(
              'Destination: ' + booking.destination + ' \nETA: ' + booking.eta),
          subtitle: Text('Pick Up Point: ' +
              booking.pickUpPoint +
              ' \nBoarding Time: ' +
              booking.pickUpTime +
              '\nDate: ' +
              booking.selectedDate),
        ),
      ),
    );
  }
}
