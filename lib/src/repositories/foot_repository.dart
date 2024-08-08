import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:multisol/src/helpers/open_alert_dialog.dart';
import 'package:path/path.dart' as p;

class FootRepository {
  Future<String?> uploadImage(File image, String uid, String footId) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users/${uid}/${footId}/${p.basename(image.path)}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      openAlertDialog(title: '사진 업로드 실패', content: e.toString());
      return null;
    }
  }
}
