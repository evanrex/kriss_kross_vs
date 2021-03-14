import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kriss_kross_vs/models/location.dart';

class DatabaseService {
  //collection reference

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  final CollectionReference locationsCollection =
      Firestore.instance.collection('locations');

  Future updateUserData(String name, String phone, String email) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  //locations list from snapshot
  List<Location> _locationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Location(
        name: doc.data['Name'] ?? '',
        geoPoint: doc.data['GeoPoint'] ?? null,
      );
    }).toList();
  }

  Stream<List<Location>> get locations {
    return locationsCollection.snapshots().map(_locationListFromSnapshot);
  }

  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
