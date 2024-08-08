import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../helpers/open_alert_dialog.dart';
import '../../../models/user_model.dart';
import 'auth_controller.dart';

class SignupPageController extends GetxController {
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

  @override
  void onInit() async {
    super.onInit();
    keyboardVisibilityController = KeyboardVisibilityController();
  }

  void initializeUserData(String userId, String userEmail) {
    uid.value = userId;
    email.value = userEmail;
    print("이메일 이거일걸${email.value}");
    emailController.text = email.value;
  }

  void bodyShapeButton(int type) {
    bodyController(type);
  }

  Future<void> signUpButton() async {
    FocusScope.of(Get.context!).unfocus();
    isSignupLoading(true);
    if (nameController.text == '') {
      isSignupLoading(false);
      openAlertDialog(title: '이름을 입력해주세요');
    } else if (contactController.text == '') {
      isSignupLoading(false);
      openAlertDialog(title: '연락처를 입력해주세요');
    } else if (emailController.text == '') {
      isSignupLoading(false);
      openAlertDialog(title: '이메일을 입력해주세요');
    } else if (heightController.text == '') {
      isSignupLoading(false);
      openAlertDialog(title: '신장을 입력해주세요');
    } else if (weightController.text == '') {
      isSignupLoading(false);
      openAlertDialog(title: '몸무게를 입력해주세요');
    } else if (bodyController.value == 0) {
      isSignupLoading(false);
      openAlertDialog(title: '체형을 선택해주세요');
    } else {
      UserModel userData = UserModel(
        uid: uid.value,
        name: nameController.text,
        contact: contactController.text,
        email: emailController.text,
        height: int.parse(heightController.text),
        weight: int.parse(weightController.text),
        description: descriptionController.text,
        body: bodyController.value,
        addition: additionController.text,
        isSubmit: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      // 회원가입 처리
      await AuthController.to.signUp(userData);
      isSignupLoading(false);
    }
  }
}
