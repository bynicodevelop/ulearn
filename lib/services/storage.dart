import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;

class StorageService {
  FirebaseStorage _storageReference = FirebaseStorage.instance;

  Future<Map<String, dynamic>> loadActivites() async {
    StorageReference storageReference =
        _storageReference.ref().child('activites.json');

    var url = await storageReference.getDownloadURL();

    var response = await http.get(url.toString());

    return jsonDecode(response.body);
  }

  Future<String> uploadFile(File file) async {
    StorageReference storageReference =
        _storageReference.ref().child('users/${Path.basename(file.path)}');

    StorageUploadTask uploadTask = storageReference.putFile(file);

    await uploadTask.onComplete;

    var url = await storageReference.getDownloadURL();

    return url.toString();
  }
}
