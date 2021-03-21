import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/booking_model.dart';
import 'package:kriss_kross_vs/screens/home/booking_tile.dart';
import 'package:provider/provider.dart';

class BookingsList extends StatefulWidget {
  @override
  _BookingsListState createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    final bookings = Provider.of<List<Booking>>(context) ?? [];
    bookings.forEach((booking_model) {
      print(booking_model.userName);
      print(booking_model.destination);
    });

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (conext, index) {
        return BookingTile(booking: bookings[index]);
      },
    );
  }
}
