import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/booking_model.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/screens/home/booking_tile.dart';
import 'package:kriss_kross_vs/services/database.dart';
import 'package:kriss_kross_vs/shared/loading.dart';
import 'package:provider/provider.dart';

class BookingsList extends StatefulWidget {
  @override
  _BookingsListState createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //final bookings = Provider.of<List<Booking>>(context) ?? [];
    if (user.uid == null) {
      print('uid null in bookings_list');
    } else {
      print(user.uid);
    }
    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).bookings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Booking> bookings = snapshot.data;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (conext, index) {
                return BookingTile(booking: bookings[index]);
              },
            );
          } else {
            return Loading();
          }
        });
  }
}
