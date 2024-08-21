import 'package:get/get.dart';

import '../../../models/foot_model.dart';
import '../../../repositories/foot_repository.dart';

class FootAdminListPageController extends GetxController {
  Stream<List<FootModel>> footModelListStream() {
    return FootRepository().footModelListGroupStream();
  }

  void footListTileButton(FootModel footModel) {}
}
