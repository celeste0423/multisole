import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/controllers/pay_page_controller.dart';
import 'package:multisol/src/widgets/main_button.dart';

import '../../../utils/custom_color.dart';

class PayPage extends GetView<PayPageController> {
  const PayPage({super.key});

  Widget _imageBox() {
    return Image.asset('assets/images/shoe.png');
  }

  Widget _textBox() {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 100),
      child: Text(
        '주문이 완료되었습니다!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: CustomColors.blackText,
          fontSize: 25,
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
      body: Stack(
        children: [
          _imageBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _textBox(),
                Expanded(child: SizedBox()),
                _button(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
