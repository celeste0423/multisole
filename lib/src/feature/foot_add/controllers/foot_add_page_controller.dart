import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/feature/foot_add/pages/foot_image_add_page.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/open_alert_dialog.dart';
import '../../../models/foot_model.dart';

class FootAddPageController extends GetxController {
  Rx<bool> isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rx<int> bodyController = 0.obs;
  TextEditingController additionController = TextEditingController();

  var uuid = Uuid();

  @override
  void onInit() {
    nameController.text = AuthController.to.user.value.name ?? '';
    contactController.text = AuthController.to.user.value.contact ?? '';
    emailController.text = AuthController.to.user.value.email ?? '';
    heightController.text = AuthController.to.user.value.height.toString();
    weightController.text = AuthController.to.user.value.weight.toString();
    descriptionController.text = AuthController.to.user.value.description ?? '';
    bodyController(AuthController.to.user.value.body);
    additionController.text = AuthController.to.user.value.addition ?? '';
    super.onInit();
  }

  void bodyShapeButton(int type) {
    bodyController(type);
  }

  Future<void> sendButton() async {
    FocusScope.of(Get.context!).unfocus();
    isLoading(true);
    if (nameController.text == '') {
      isLoading(false);
      openAlertDialog(title: '이름을 입력해주세요');
    } else if (contactController.text == '') {
      isLoading(false);
      openAlertDialog(title: '연락처를 입력해주세요');
    } else if (emailController.text == '') {
      isLoading(false);
      openAlertDialog(title: '이메일을 입력해주세요');
    } else if (heightController.text == '') {
      isLoading(false);
      openAlertDialog(title: '신장을 입력해주세요');
    } else if (weightController.text == '') {
      isLoading(false);
      openAlertDialog(title: '몸무게를 입력해주세요');
    } else if (bodyController.value == 0) {
      isLoading(false);
      openAlertDialog(title: '체형을 선택해주세요');
    } else {
      FootModel footModel = FootModel(
        footId: uuid.v4(),
        uid: AuthController.to.user.value.uid,
        name: nameController.text,
        contact: contactController.text,
        email: emailController.text,
        height: int.parse(heightController.text),
        weight: int.parse(weightController.text),
        description: descriptionController.text,
        body: bodyController.value,
        addition: additionController.text,
        isCompleted: 0,
      );

      Get.to(() => FootImageAddPage(), arguments: footModel.toJson());

      isLoading(false);
    }
  }
}
