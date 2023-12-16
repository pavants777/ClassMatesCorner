import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Store {
  static Future<String> storeFileToFirebase(String path, File? file) async {
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(path).putFile(file!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
