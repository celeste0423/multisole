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

  TextEditingController nicknameController = TextEditingController();

  Rx<bool> isTermAgreed = false.obs;

  @override
  void onInit() async {
    super.onInit();
    keyboardVisibilityController = KeyboardVisibilityController();
  }

  Future<void> signUpButton() async {
    isSignupLoading(true);
    if (nicknameController.text == '') {
      isSignupLoading(false);
      openAlertDialog(title: '닉네임을 입력해주세요');
    } else if (!isTermAgreed.value) {
      isSignupLoading(false);
      openAlertDialog(title: '이용약관 및 개인정보처리방침에 동의해주세요');
    } else {
      UserModel userData = UserModel(
        uid: uid.value,
        nickname: nicknameController.text,
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
