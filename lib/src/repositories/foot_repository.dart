import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multisol/src/helpers/open_alert_dialog.dart';
import 'package:path/path.dart' as p;

import '../models/foot_model.dart';

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

  Future<void> uploadFootModel(FootModel footModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(footModel.uid)
          .collection('foot')
          .doc(footModel.footId)
          .set(footModel.toJson());
    } catch (e) {
      openAlertDialog(title: '발모델 생성에 실패했습니다.', content: e.toString());
    }
  }

  Future<void> update(FootModel footModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(footModel.uid)
          .collection('foot')
          .doc(footModel.footId)
          .update(footModel.toJson());
    } catch (e) {
      openAlertDialog(title: '발모델 업데이트에 실패했습니다.', content: e.toString());
    }
  }
}
