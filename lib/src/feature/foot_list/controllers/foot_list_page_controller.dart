import 'package:get/get.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/feature/print/pages/view_model_page.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/repositories/foot_repository.dart';

import '../../../helpers/open_alert_dialog.dart';

class FootListPageController extends GetxController {
  Stream<List<FootModel>> footModelListStream() {
    print('uid : ${AuthController.to.user.value.uid!}');
    return FootRepository()
        .footModelListStream(AuthController.to.user.value.uid!);
  }

  void footListTileButton(FootModel footModel) {
    switch (footModel.isCompleted) {
      case 0:
        openAlertDialog(title: '모델 생성중입니다.', content: '잠시만 기다려주세요.');
        break;
      case 1:
        Get.to(() => ViewModelPage(footModel: footModel));
        break;
      case 2:
        openAlertDialog(title: '배송 중 입니다.', content: '잠시만 기다려주세요.');
        break;
      default:
        openAlertDialog(title: '오류 발생');
        break;
    }
  }
}
