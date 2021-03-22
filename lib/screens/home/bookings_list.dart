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

    bool futureBooking(Booking booking) {
      String selectedDate = booking.selectedDate.toString();
      print('selectedDate: ' + selectedDate);
      DateTime bookingDate = DateTime.parse(selectedDate);
      print('bookingDate: ' + bookingDate.toString());
      DateTime now = new DateTime.now();
      print('now: ' + now.toString());

      if (bookingDate.isBefore(now)) {
        print('selected date is before now');
        print('\n');
        return false;
      } else {
        print('selected date is after now');
        print('\n');
        return true;
      }
    }

    DateTime now = new DateTime.now();

    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).bookings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Booking> bookings = snapshot.data;
            return Column(
              children: [
                Text('Upcoming Bookings: '),
                SingleChildScrollView(
                  // <-- wrap this around
                  child: SizedBox(
                    height: 125.0,
                    child: ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        if (futureBooking(bookings[index])) {
                          return BookingTile(booking: bookings[index]);
                        } else {
                          return SizedBox(height: 1.0);
                        }
                      },
                    ),
                  ),
                ),
                Text('Past Bookings: '),
                SingleChildScrollView(
                  // <-- wrap this around
                  child: SizedBox(
                    height: 125.0,
                    child: ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        if (!futureBooking(bookings[index])) {
                          return BookingTile(booking: bookings[index]);
                        } else {
                          return SizedBox(height: 1.0);
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Loading();
          }
        });
  }
}
