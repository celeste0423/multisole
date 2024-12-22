import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

class MyPageController extends GetxController {
  static MyPageController get to => Get.find();

  void signOutButton() {
    AuthController.to.signOut();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
