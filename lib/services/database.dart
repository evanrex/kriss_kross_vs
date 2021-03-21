import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kriss_kross_vs/models/location.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/models/booking_model.dart';

class DatabaseService {
  //collection reference

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  final CollectionReference locationsCollection =
      Firestore.instance.collection('locations');

  final CollectionReference bookingsCollection =
      Firestore.instance.collection('bookings');

  Future updateUserData(String name, String phone, String email) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  Future makeBooking(
    String userName,
    String userPhone,
    String destination,
    String eta,
    String pickUpPoint,
    String pickUpTime,
    String selectedDate,
    String userUID,
  ) async {
    return await bookingsCollection.document().setData({
      'userName': userName,
      'userPhone': userPhone,
      'destination': destination,
      'eta': eta,
      'pickUpPoint': pickUpPoint,
      'pickUpTime': pickUpTime,
      'selectedDate': selectedDate,
      'uid': userUID,
    });
  }

  //user data from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        phone: snapshot.data['phone'],
        email: snapshot.data['email']);
  }

  //locations list from snapshot
  List<Location> _locationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Location(
        name: doc.data['Name'] ?? '',
        geoPoint: doc.data['GeoPoint'] ?? null,
        arrivalTime: doc.data['Arrival Time'] ?? null,
        pickUpLocations: doc.data['PickUpLocations'] ?? null,
        travelTimes: doc.data['Travel Time'] ?? null,
      );
    }).toList();
  }

  List<Booking> _bookingsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Booking(
        docID: doc.documentID,
        userName: doc.data['userName'] ?? '',
        userPhone: doc.data['userPhone'] ?? null,
        destination: doc.data['destination'] ?? null,
        pickUpPoint: doc.data['pickUpPoint'] ?? null,
        pickUpTime: doc.data['pickUpTime'] ?? null,
        eta: doc.data['eta'] ?? null,
        selectedDate: doc.data['selectedDate'] ?? null,
      );
    }).toList();
  }

  Stream<List<Location>> get locations {
    return locationsCollection.snapshots().map(_locationListFromSnapshot);
  }

  Stream<List<Booking>> get bookings {
    return bookingsCollection.snapshots().map(_bookingsListFromSnapshot);
  }

  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }

  //get user doc stream
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
