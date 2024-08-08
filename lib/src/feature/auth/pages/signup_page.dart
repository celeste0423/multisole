import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/full_size_loading_indicator.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_field_box.dart';
import '../controllers/signup_page_controller.dart';

class SignupPage extends GetView<SignupPageController> {
  final String uid;
  final String email;

  const SignupPage({
    Key? key,
    required this.uid,
    required this.email,
  }) : super(key: key);

  Widget _logoBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
      child: Image.asset(
        'assets/images/logo.png',
        width: Get.width,
      ),
    );
  }

  Widget _inputTab() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _firstRow(),
            TextFieldBox(
              textEditingController: controller.emailController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: 'email 주소',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            _thirdRow(),
            _bodySelector(),
            TextFieldBox(
              textEditingController: controller.additionController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '추가 요청사항',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MainButton(
                    buttonText: '회원 가입 >',
                    onTap: () {
                      controller.signUpButton();
                    },
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFieldBox(
            textEditingController: controller.nameController,
            backgroundColor: CustomColors.lightGreyBackground,
            hintText: '이름',
            maxLength: 8,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            autoFocus: true,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 3,
          child: TextFieldBox(
            textEditingController: controller.contactController,
            backgroundColor: CustomColors.lightGreyBackground,
            hintText: '연락처',
            maxLength: 11,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
          ),
        ),
      ],
    );
  }

  Widget _thirdRow() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFieldBox(
            textEditingController: controller.heightController,
            keyboardType: TextInputType.number,
            backgroundColor: CustomColors.lightGreyBackground,
            hintText: '신장(cm)',
            maxLength: 3,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: TextFieldBox(
            textEditingController: controller.weightController,
            keyboardType: TextInputType.number,
            backgroundColor: CustomColors.lightGreyBackground,
            hintText: '몸무게(kg)',
            maxLength: 3,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 2,
          child: TextFieldBox(
            textEditingController: controller.descriptionController,
            backgroundColor: CustomColors.lightGreyBackground,
            hintText: '특이사항',
            maxLength: 13,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
          ),
        ),
      ],
    );
  }

  Widget _bodySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '체형',
          style: TextStyle(
            color: CustomColors.whiteText,
            fontSize: 10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _bodyShapeButton('assets/images/triangle.png', 1),
            _bodyShapeButton('assets/images/square.png', 2),
            _bodyShapeButton('assets/images/circle.png', 3),
          ],
        ),
      ],
    );
  }

  Widget _bodyShapeButton(String imagePath, int type) {
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          controller.bodyShapeButton(type);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 75,
            ),
            SizedBox(height: 15),
            Obx(
              () => Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: type == controller.bodyController.value
                      ? CustomColors.mainOrange
                      : CustomColors.greyBackground,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    Get.put(SignupPageController());
    controller.initializeUserData(uid, email);
    return Stack(
      children: [
        KeyboardDismissOnTap(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: CustomColors.mainBlack,
            body: SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(Get.context!).padding.top),
                    _logoBox(),
                    _inputTab(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isSignupLoading.value,
            child: FullSizeLoadingIndicator(
              backgroundColor: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
