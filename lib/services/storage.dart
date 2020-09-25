import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class StorageService {
  FirebaseStorage _storageReference = FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    StorageReference storageReference =
        _storageReference.ref().child('users/${Path.basename(file.path)}');

    StorageUploadTask uploadTask = storageReference.putFile(file);

    await uploadTask.onComplete;

    print('Uploaded');
    var url = await storageReference.getDownloadURL();

    return url.toString();
  }
}
