import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/pages/print_menu_page.dart';
import 'package:multisol/src/helpers/open_alert_dialog.dart';
import 'package:multisol/src/models/foot_model.dart';

class ViewModelPageController extends GetxController {
  Flutter3DController modelController = Flutter3DController();

  Future<File?> downloadAndCacheFile(String firebaseUrl) async {
    try {
      // 캐시 매니저를 사용하여 파일 다운로드
      var fileResponse = await DefaultCacheManager().downloadFile(firebaseUrl);
      var file = fileResponse.file;
      print("다운로드 파일 위치: ${file.path}");
      if (file.existsSync() && file.lengthSync() > 0) {
        print("File exists and is valid: ${file.path}");
        return file;
      } else {
        print("File is empty or invalid: ${file.path}");
        return null;
      }
    } catch (e) {
      // 오류 발생 시 알림창 열기
      openAlertDialog(title: "파일 다운로드 실패: $e");
      return null;
    }
  }

  void pageButton(FootModel footModel) {
    Get.to(() => PrintMenuPage(footModel: footModel));
  }
}
