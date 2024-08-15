import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/utils/custom_color.dart';
import 'package:multisol/src/widgets/main_button.dart';

import '../controllers/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  Widget _logoBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
      child: Image.asset(
        'assets/images/logo.png',
        width: Get.width,
      ),
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
              buttonText: '> 출력하기',
              onTap: controller.printButton,
            ),
            MainButton(
              buttonText: '> 발 정보 새로 입력',
              onTap: controller.footAddButton,
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: controller.signOutButton,
              child: const Text(
                '로그아웃',
                style: TextStyle(
                  color: CustomColors.greyText,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Scaffold(
      backgroundColor: CustomColors.mainBlack,
      body: Column(
        children: [
          SizedBox(height: 30),
          _logoBox(),
          _buttonTab(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
