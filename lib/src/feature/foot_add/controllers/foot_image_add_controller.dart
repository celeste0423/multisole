import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/models/foot_model.dart';
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

  void uploadButton() {
    isLoading(true);
    isLoading(false);
  }
}
