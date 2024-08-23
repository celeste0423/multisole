import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/pages/admin_file_upload_page.dart';

import '../../../models/foot_model.dart';
import '../../../repositories/foot_repository.dart';

class FootAdminListPageController extends GetxController {
  Stream<List<FootModel>> footModelListStream() {
    return FootRepository().footModelListGroupStream();
  }

  void footListTileButton(FootModel footModel) {
    Get.to(() => AdminFileUploadPage(footModel: footModel));
  }
}
