import 'package:get/get.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/feature/foot_add/pages/foot_add_page.dart';
import 'package:multisol/src/feature/print/pages/print_menu_page.dart';

class HomePageController extends GetxController {
  void printButton() {
    Get.to(() => PrintMenuPage());
  }

  void footAddButton() {
    Get.to(() => FootAddPage());
  }

  void loadInfoButton() {}

  void signOutButton() {
    AuthController.to.signOut();
  }
}
