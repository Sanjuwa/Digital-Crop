import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalcrop/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  createUser(User user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set({'name': user.name, 'id': user.uid, 'email': user.email, 'lastImageDate': null, 'imageCountForLastDay': 0});
  }

  getLastImageInfo(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return {
      'lastImageDate' : doc['lastImageDate'],
      'imageCountForLastDay': doc['imageCountForLastDay']
    };
  }

  updateLastImageInfo(DateTime date, int count, String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'lastImageDate': date,
      'imageCountForLastDay': count
    });
  }

  // getUserDetails(User user) async {
  //   await _firestore.collection('users').doc(user.uid).get().then((doc) {
  //     user.name = doc['name'];
  //   });
  // }

  // deleteUser(User user) async {
  //   await _firestore.collection('users').doc(user.uid).delete();
  // }
}
