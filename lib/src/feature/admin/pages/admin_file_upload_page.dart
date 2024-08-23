import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/controllers/admin_file_upload_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/widgets/main_button.dart';
import 'package:multisol/src/widgets/title_text.dart';

import '../../../widgets/full_size_loading_indicator.dart';

class AdminFileUploadPage extends GetView<AdminFileUploadPageController> {
  FootModel footModel;

  AdminFileUploadPage({
    Key? key,
    required this.footModel,
  }) : super(key: key);

  Widget _uploadButton() {
    return MainButton(
      buttonText: '파일 업로드(.glb .gltf)',
      onTap: () {
        controller.uploadFile(footModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AdminFileUploadPageController());
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: TitleText(text: '파일 업로드'),
          ),
          body: _uploadButton(),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoading.value,
            child: FullSizeLoadingIndicator(
              backgroundColor: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
