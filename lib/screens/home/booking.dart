import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/services/database.dart';
import 'package:kriss_kross_vs/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget {
  final Location location;

  Booking({Key key, @required this.location}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String _desiredETA;
  String _desiredPickUp;
  String pickUpTime = '';
  String selectedDate = '';
  String chosenDate = "Please Select a Date";
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  DateTime _date = new DateTime.now().add(Duration(days: 1));
  DateTime selectedDate1 = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: _date,
      lastDate: _date.add(Duration(days: 14)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = formatter.format(picked);
        chosenDate = 'Selected Date: ' + formatter.format(picked);
      });
    }
  }

  String pickupTime(Map travelTimes, String destination, String eta) {
    if (eta == null || destination == null) {
      return 'Choose desired ETA and/or Boarding point';
    }
    if (eta.length < 5) {
      return eta.length.toString();
    }

    int tt = int.parse(travelTimes[destination].toString());
    //int tt = 10;
    int estMin = int.parse(eta[3]) * 10 + int.parse(eta[4]);
    int estHour = int.parse(eta[0]) * 10 + int.parse(eta[1]);

    estMin -= tt;
    if (estMin < 0) {
      estHour--;
      estMin += 60;
    }

    pickUpTime = estHour.toString() + ':' + estMin.toString() + '\n' + '\n';

    return 'Boarding time: ' +
        pickUpTime +
        'Please be at pick up point 5 minutes before boarding time.';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
                backgroundColor: Colors.brown[100],
                appBar: AppBar(
                  backgroundColor: Colors.brown[400],
                  elevation: 0.0,
                  title: Text('Book trip to ' + widget.location.name),
                ),
                body: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        //drop down:
                        RaisedButton(
                          child: Text(chosenDate),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                        DropdownButtonFormField(
                          hint: Text('Select desired ETA'),
                          items: widget.location.arrivalTime.map((eta) {
                            return DropdownMenuItem(
                                value: eta, child: Text('ETA: ' + '$eta'));
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _desiredETA = value),
                        ),

                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          hint: Text('Select desired boarding point'),
                          items: widget.location.pickUpLocations.map((point) {
                            return DropdownMenuItem(
                                value: point,
                                child: Text('Board at: ' + '$point'));
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _desiredPickUp = value),
                        ),

                        SizedBox(height: 20.0),
                        SizedBox(height: 20.0),

                        Text(pickupTime(widget.location.travelTimes,
                            _desiredPickUp, _desiredETA)),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            ElevatedButton(
                                //color: Colors.pink[400],
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.pink[400],
                                ),
                                child: Text('Book',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () async {
                                  await DatabaseService().makeBooking(
                                    userData.name,
                                    userData.phone,
                                    widget.location.name,
                                    _desiredETA,
                                    _desiredPickUp,
                                    pickUpTime,
                                    selectedDate,
                                    userData.uid,
                                  );
                                  Navigator.pop(context);
                                }),
                            SizedBox(width: 20.0),
                            ElevatedButton(
                                //color: Colors.pink[400],
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.pink[400],
                                ),
                                child: Text('Cancel',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
