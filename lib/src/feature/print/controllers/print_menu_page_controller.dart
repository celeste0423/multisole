import 'package:get/get.dart';
import 'package:multisol/src/feature/print/pages/address_input_page.dart';
import 'package:multisol/src/models/foot_model.dart';

class PrintMenuPageController extends GetxController {
  void findStoreButton() {}

  void addressInputButton(FootModel footModel) {
    Get.to(() => AddressInputPage(footModel: footModel));
  }
}
