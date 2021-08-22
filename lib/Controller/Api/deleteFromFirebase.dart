import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DeleteFromFirebase {
  deleteFormFirebase(dynamic object, String collectionPath) async {
    await FirebaseFirestore.instance
      ..collection(collectionPath).doc(object.id).delete();
  }
}
