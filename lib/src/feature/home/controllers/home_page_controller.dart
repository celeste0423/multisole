import 'package:get/get.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/feature/foot_add/pages/foot_add_page.dart';
import 'package:multisol/src/feature/foot_list/pages/foot_list_page.dart';

class HomePageController extends GetxController {
  void printButton() {
    Get.to(() => FootListPage());
  }

  void footAddButton() {
    Get.to(() => FootAddPage());
  }

  void loadInfoButton() {}

  void signOutButton() {
    AuthController.to.signOut();
  }
}
