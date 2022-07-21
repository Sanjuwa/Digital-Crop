import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalcrop/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  createUser(User user) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set({'name': user.name, 'id': user.uid, 'email': user.email});
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
