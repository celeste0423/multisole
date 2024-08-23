import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/controllers/view_model_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/widgets/main_button.dart';

import '../../../widgets/image_icon_button.dart';
import '../../home/pages/home_page.dart';

class ViewModelPage extends GetView<ViewModelPageController> {
  FootModel footModel;

  ViewModelPage({required this.footModel, super.key});

  PreferredSizeWidget _appbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: ImageIconButton(
        onTap: () {
          Get.back();
        },
        assetPath: 'assets/icons/back.png',
        height: 35,
        isPng: true,
      ),
      actions: [
        ImageIconButton(
          onTap: () {
            Get.offAll(() => HomePage());
          },
          assetPath: 'assets/icons/home.png',
          height: 35,
          isPng: true,
        ),
      ],
    );
  }

  // Widget _modelView() {
  //   return FutureBuilder<File?>(
  //     future: controller.downloadAndCacheFile(footModel.fileUrl!),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError || !snapshot.hasData) {
  //         return Center(child: Text('모델을 로드할 수 없습니다.'));
  //       } else {
  //         File? file = snapshot.data;
  //         return Flutter3DViewer(
  //           src: file!.path!,
  //           // 로컬 파일 경로를 전달
  //           // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
  //           controller: controller.modelController,
  //         );
  //       }
  //     },
  //   );
  // }

  Widget _modelView() {
    print('주소 : ${footModel.fileUrl!}');
    return Flutter3DViewer(
      src: footModel.fileUrl!,
      // 로컬 파일 경로를 전달
      // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
      // controller: controller.modelController,
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: MainButton(
        buttonText: '배송 정보 입력하기',
        height: 55,
        onTap: () {
          controller.pageButton(footModel);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ViewModelPageController());
    return Scaffold(
      appBar: _appbar(),
      body: Column(
        children: [
          Expanded(child: _modelView()),
          _button(),
        ],
      ),
    );
  }
}
