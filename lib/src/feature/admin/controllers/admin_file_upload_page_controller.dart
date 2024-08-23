import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/pages/admin_page.dart';
import 'package:multisol/src/helpers/open_alert_dialog.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/repositories/foot_repository.dart';
import 'package:uuid/uuid.dart';

class AdminFileUploadPageController extends GetxController {
  Rx<bool> isLoading = false.obs;

  void uploadFile(FootModel footModel) async {
    isLoading(true);
    String? downloadLink = await uploadGLBFile(footModel);
    if (downloadLink != null) {
      FootModel updatedFootModel = footModel.copyWith(
        fileUrl: downloadLink,
        isCompleted: 1,
        updatedAt: DateTime.now(),
      );
      FootRepository().update(updatedFootModel);
      Get.offAll(AdminPage());
      isLoading(false);
    } else {
      isLoading(false);
      openAlertDialog(title: '오류발생', content: '파일이 업로드되지 않았습니다.');
    }
  }

  Future<String?> uploadGLBFile(FootModel footModel) async {
    try {
      // 파일 선택기 열기 (glb 파일만 허용)
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        // 선택된 파일의 경로
        String filePath = result.files.single.path!;

        // 파일 확장자 추출
        String? fileExtension = result.files.single.extension;

        // 고유 파일 이름 생성 (확장자에 따라)
        String fileName;
        if (fileExtension == 'glb') {
          fileName = '${Uuid().v4()}.glb';
        } else if (fileExtension == 'gltf') {
          fileName = '${Uuid().v4()}.gltf';
        } else {
          // 만약 파일 확장자가 예상치 못한 경우
          openAlertDialog(title: '지원되지 않는 파일 형식입니다.');
          return null;
        }

        // Firebase Storage에 파일 업로드
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('users/${footModel.uid}/${footModel.footId}/$fileName');
        UploadTask uploadTask = storageReference.putFile(File(filePath));

        // 업로드 완료 대기
        await uploadTask.whenComplete(() => null);

        // 업로드된 파일의 다운로드 URL 받기
        String downloadURL = await storageReference.getDownloadURL();

        // 다운로드 URL 반환
        return downloadURL;
      } else {
        print('파일 선택이 취소되었습니다.');
        return null;
      }
    } catch (e) {
      print('파일 업로드 중 오류 발생: $e');
      return null;
    }
  }
}
