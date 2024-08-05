import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../helpers/open_alert_dialog.dart';
import '../../../models/user_model.dart';
import 'auth_controller.dart';

class SignupPageController extends GetxController {
  bool? isProfileEditing = Get.arguments;
  late KeyboardVisibilityController keyboardVisibilityController;

  Rx<String> uid = ''.obs;
  Rx<String> email = ''.obs;

  Rx<bool> isSignupLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rx<int> bodyController = 0.obs;
  TextEditingController additionController = TextEditingController();

  Rx<bool> isTermAgreed = false.obs;

  @override
  void onInit() async {
    super.onInit();
    keyboardVisibilityController = KeyboardVisibilityController();
    emailController.text = email.value;
  }

  void bodyShapeButton(int type) {
    bodyController(type);
  }

  Future<void> signUpButton() async {
    isSignupLoading(true);
    if (nameController.text == '') {
      isSignupLoading(false);
      openAlertDialog(title: '닉네임을 입력해주세요');
    } else if (!isTermAgreed.value) {
      isSignupLoading(false);
      openAlertDialog(title: '이용약관 및 개인정보처리방침에 동의해주세요');
    } else {
      UserModel userData = UserModel(
        uid: uid.value,
        name: nameController.text,
        email: email.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      // 회원가입 처리
      await AuthController.to.signUp(userData);
      isSignupLoading(false);
    }
  }
}
