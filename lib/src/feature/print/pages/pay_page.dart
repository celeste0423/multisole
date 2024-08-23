import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/controllers/pay_page_controller.dart';
import 'package:multisol/src/widgets/main_button.dart';

import '../../../utils/custom_color.dart';

class PayPage extends GetView<PayPageController> {
  const PayPage({super.key});

  Widget _imageBox() {
    return Expanded(
      child: Image.asset('assets/images/foot_wait.png'),
    );
  }

  Widget _textBox() {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 30),
      child: Text(
        '계좌번호로 계좌이체 부탁드립니다.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: CustomColors.whiteText,
        ),
      ),
    );
  }

  Widget _button() {
    return MainButton(buttonText: '홈으로', onTap: controller.homeButton);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PayPageController());
    return Scaffold(
      body: Column(
        children: [
          _imageBox(),
          _textBox(),
          _button(),
        ],
      ),
    );
  }
}
