import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/services/database.dart';
import 'package:kriss_kross_vs/shared/constants.dart';
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
  String chosenDate = "Select a Date";
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  DateTime _date = new DateTime.now().add(Duration(days: 1));
  DateTime selectedDate1 = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: _date,
      lastDate: _date.add(Duration(days: 14)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pink[400],
            accentColor: Colors.pink[400],
            colorScheme: ColorScheme.light(primary: Colors.pink[400]),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
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

    String estHStr = '00';
    String estMStr = '00';

    if (estHour.toString().length == 1) {
      estHStr = '0' + estHour.toString();
    } else {
      estHStr = estHour.toString();
    }
    if (estMin.toString().length == 1) {
      estMStr = '0' + estMin.toString();
    } else {
      estMStr = estMin.toString();
    }

    pickUpTime = estHStr + ':' + estMStr;

    return 'Boarding time: ' +
        pickUpTime +
        '\n\nPlease be at pick up point 5 minutes before boarding time.';
  }

  final _formKey = GlobalKey<FormState>();
  String error = '';
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
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          //drop down:
                          TextButton.icon(
                            icon:
                                Icon(Icons.calendar_today, color: Colors.white),
                            //color: Colors.white,
                            label: Text(chosenDate,
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                          DropdownButtonFormField(
                            decoration: testInputDecoration.copyWith(
                                hintText: 'Select desired ETA'),
                            items: widget.location.arrivalTime.map((eta) {
                              return DropdownMenuItem(
                                  value: eta, child: Text('ETA: ' + '$eta'));
                            }).toList(),
                            validator: (value) =>
                                value.isEmpty ? 'Please select an ETA' : null,
                            onChanged: (value) =>
                                setState(() => _desiredETA = value),
                          ),

                          SizedBox(height: 20.0),
                          DropdownButtonFormField(
                            decoration: testInputDecoration.copyWith(
                                hintText: 'Select desired boarding point'),
                            items: widget.location.pickUpLocations.map((point) {
                              return DropdownMenuItem(
                                  value: point,
                                  child: Text('Board at: ' + '$point'));
                            }).toList(),
                            validator: (value) => value.isEmpty
                                ? 'Please select a Boarding Point'
                                : null,
                            onChanged: (value) =>
                                setState(() => _desiredPickUp = value),
                          ),

                          SizedBox(height: 20.0),
                          SizedBox(height: 20.0),

                          Text(
                            pickupTime(widget.location.travelTimes,
                                    _desiredPickUp, _desiredETA) +
                                '\n\n' +
                                chosenDate,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          // SizedBox(height: 12.0),
                          // Text(
                          //   chosenDate,
                          //   style:
                          //       TextStyle(color: Colors.white, fontSize: 16.0),
                          // ),
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
                                    if (_formKey.currentState.validate() &&
                                        selectedDate != '') {
                                      print(selectedDate);
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
                                    } else {
                                      error = 'Select ETA/Pick Up Location';
                                    }
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
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
