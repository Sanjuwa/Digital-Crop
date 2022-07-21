import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService{

  final _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File file, String name) async {
    try{
      Reference reference = _storage.ref('$name.jpg');
      TaskSnapshot task = await reference.putFile(file);
      String? url = await task.ref.getDownloadURL();

      return url;
    }
    catch (e){
      return null;
    }
  }

}