import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/title_text.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/my_page_controller.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({super.key});

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      title: TitleText(
        text: 'My',
      ),
    );
  }

  Widget _profile() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${AuthController.to.user.value.name}님 \n안녕하세요 :)',
            style: const TextStyle(
              color: CustomColors.blackText,
              fontSize: 24,
            ),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            color: CustomColors.lightGreyBackground,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(35)),
            child: OverflowBox(
              maxHeight: double.infinity,
              maxWidth: double.infinity,
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/profile.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _button('나의 인솔 히스토리', () {}),
        _button('멀티솔 이용방법', () {}),
        _button('1:1 문의하기', () {}),
        _button('서비스 이용 약관', () {}),
        _button('개인정보처리방침', () {}),
        _button('로그아웃', () {
          controller.signOutButton();
        }),
      ],
    );
  }

  Widget _button(String text, VoidCallback onTap) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 5),
      onPressed: onTap,
      child: Container(
        height: 60,
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: CustomColors.blackText,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MyPageController());
    return SafeArea(
      child: Scaffold(
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  _profile(),
                  _buttons(),
                  const SizedBox(height: 95),
                ],
              ),
            ),
          )),
    );
  }
}
