import 'package:get/get.dart';
import 'package:multisol/src/feature/home/pages/home_page.dart';

class PayPageController extends GetxController {
  void homeButton() {
    Get.offAll(HomePage());
  }
}
