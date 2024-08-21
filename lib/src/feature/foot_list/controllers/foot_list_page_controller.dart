import 'package:get/get.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/repositories/foot_repository.dart';

class FootListPageController extends GetxController {
  Stream<List<FootModel>> footModelListStream() {
    print('uid : ${AuthController.to.user.value.uid!}');
    return FootRepository()
        .footModelListStream(AuthController.to.user.value.uid!);
  }

  void footListTileButton(FootModel footModel) {}
}
