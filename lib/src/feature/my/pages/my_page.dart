import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/open_alert_dialog.dart';
import '../../../utils/custom_color.dart';
import '../../../widgets/title_text.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/my_page_controller.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({super.key});

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
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
              child: Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.only(right: 2, bottom: 10),
              ),
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
        _button(
          Image.asset(
            'assets/icons/my_data_analyze.png',
            width: 30,
            height: 30,
          ),
          '기록 분석',
          () {
            openAlertDialog(title: '추후 구현 예정입니다.');
          },
        ),
        _button(
          const Icon(
            Icons.analytics_outlined,
            size: 30,
            color: CustomColors.mainBlack,
          ),
          '결과 보기',
          () {
            openAlertDialog(title: '추후 구현 예정입니다.');
          },
        ),
        Container(
          color: CustomColors.lightGreyBackground,
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 100,
          height: 1,
        ),
        _button(
          Image.asset(
            'assets/icons/my_settings.png',
            width: 30,
            height: 30,
          ),
          '설정',
          () {
            openAlertDialog(title: '추후 구현 예정입니다.');
          },
        ),
        _button(
          Image.asset(
            'assets/icons/my_report.png',
            width: 30,
            height: 30,
          ),
          '문의하기',
          () {
            openAlertDialog(title: '추후 구현 예정입니다.');
          },
        ),
      ],
    );
  }

  Widget _button(Widget icon, String text, VoidCallback onTap) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 5),
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: CustomColors.whiteBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        height: 60,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
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
