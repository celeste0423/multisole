import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_color.dart';
import '../controllers/wait_page_controller.dart';

class WaitPage extends GetView<WaitPageController> {
  const WaitPage({super.key});

  Widget _imageBox() {
    return Expanded(
      child: Image.asset('assets/images/foot_wait.png'),
    );
  }

  Widget _textBox() {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 30),
      child: Text(
        '업로드 된 사진을 분석중입니다... \n사진 분석이 완료되면 홈 화면으로 돌아갑니다.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: CustomColors.whiteText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _imageBox(),
          _textBox(),
        ],
      ),
    );
  }
}
