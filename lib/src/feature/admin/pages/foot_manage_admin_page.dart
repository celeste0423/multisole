import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/controllers/foot_manage_admin_page_controller.dart';

class FootManageAdminPage extends GetView<FootManageAdminPageController> {
  const FootManageAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FootManageAdminPageController());
    return const Placeholder();
  }
}
