import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/feature/home/pages/home_page.dart';
import 'package:multisol/src/helpers/open_alert_dialog.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/models/user_model.dart';
import 'package:multisol/src/repositories/foot_repository.dart';

class FootImageAddController extends GetxController {
  final arguments = Get.arguments as Map<String, dynamic>;
  FootModel footModel = FootModel();
  Rx<bool> isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();
  Rx<String> frontImgUrl = ''.obs;
  Rx<String> sideImgUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    footModel = FootModel.fromJson(arguments);
  }

  void uploadFrontImage() async {
    isLoading(true);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      String? url = await FootRepository().uploadImage(
        file,
        AuthController.to.user.value.uid!,
        footModel.footId!,
      );
      if (url != null) {
        frontImgUrl(url);
      }
    }
    isLoading(false);
  }

  void uploadSideImage() async {
    isLoading(true);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      String? url = await FootRepository().uploadImage(
        file,
        AuthController.to.user.value.uid!,
        footModel.footId!,
      );
      if (url != null) {
        sideImgUrl(url);
      }
    }
    isLoading(false);
  }

  void uploadButton() async {
    isLoading(true);
    if (frontImgUrl.value == '') {
      openAlertDialog(title: '정면 사진을 업로드해주세요');
    } else if (sideImgUrl.value == '') {
      openAlertDialog(title: '측면 사진을 업로드해주세요');
    } else {
      //발모델 새로 업로드
      FootModel newFootModel = footModel.copyWith(
        frontImgUrl: frontImgUrl.value,
        sideImgUrl: sideImgUrl.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await FootRepository().uploadFootModel(newFootModel);
      //기존 유저 정보 수정
      UserModel newUserData = AuthController.to.user.value.copyWith(
        name: footModel.name,
        contact: footModel.contact,
        email: footModel.email,
        height: footModel.height,
        weight: footModel.weight,
        description: footModel.description,
        body: footModel.body,
        addition: footModel.addition,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      AuthController.to.updateUserModel(newUserData);
      Get.offAll(() => HomePage());
    }
    isLoading(false);
  }
}
