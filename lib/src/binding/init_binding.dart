import 'package:get/get.dart';

import '../feature/auth/controllers/auth_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
