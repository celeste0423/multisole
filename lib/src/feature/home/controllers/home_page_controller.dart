import 'package:get/get.dart';
import 'package:multisol/src/feature/foot_add/pages/foot_add_page.dart';

class HomePageController extends GetxController {
  void printButton() {}

  void footAddButton() {
    Get.to(() => FootAddPage());
  }

  void loadInfoButton() {}
}
