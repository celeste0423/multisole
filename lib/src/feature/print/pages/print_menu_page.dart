import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/controllers/print_menu_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/image_icon_button.dart';
import '../../../widgets/main_button.dart';
import '../../home/pages/home_page.dart';

class PrintMenuPage extends GetView<PrintMenuPageController> {
  FootModel footModel;

  PrintMenuPage({
    required this.footModel,
    super.key,
  });

  PreferredSizeWidget _appbar() {
    return AppBar(
      backgroundColor: CustomColors.mainBlack,
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

  Widget _buttonTab() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            MainButton(
              buttonText: '> 방문수령 매장 찾기',
              onTap: controller.findStoreButton,
            ),
            MainButton(
              buttonText: '> 주소지 입력하기',
              onTap: () {
                controller.addressInputButton(footModel);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PrintMenuPageController());
    return Scaffold(
      body: Column(
        children: [
          _appbar(),
          SizedBox(height: 30),
          _buttonTab(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
