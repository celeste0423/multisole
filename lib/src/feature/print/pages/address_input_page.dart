import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/controllers/address_input_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/full_size_loading_indicator.dart';
import '../../../widgets/image_icon_button.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_field_box.dart';
import '../../home/pages/home_page.dart';

class AddressInputPage extends GetView<AddressInputPageController> {
  FootModel footModel;

  AddressInputPage({required this.footModel, super.key});

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

  Widget _logoBox() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 100, right: 100, bottom: 50, top: 20),
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
              textEditingController: controller.postCodeController,
              keyboardType: TextInputType.number,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '우편번호',
              maxLength: 5,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            TextFieldBox(
              textEditingController: controller.addressController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '주소',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            TextFieldBox(
              textEditingController: controller.additionAddressController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '상세주소',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            SizedBox(height: 55),
            TextFieldBox(
              textEditingController: controller.requestController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '배송 요청사항',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: MainButton(
                buttonText: '>결제정보 선택하기',
                onTap: () {
                  controller.payButton(footModel);
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
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFieldBox(
            textEditingController: controller.deliverNameController,
            backgroundColor: CustomColors.lightGreyBackground,
            hintText: '수령인',
            maxLength: 8,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 3,
          child: TextFieldBox(
            textEditingController: controller.deliverContactController,
            keyboardType: TextInputType.number,
            backgroundColor: CustomColors.lightGreyBackground,
            hintText: '수령인 전화번호',
            maxLength: 11,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AddressInputPageController());
    return Stack(
      children: [
        KeyboardDismissOnTap(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: CustomColors.mainBlack,
            appBar: _appbar(),
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
        Obx(() => Visibility(
            visible: controller.isLoading.value,
            child: FullSizeLoadingIndicator(
              backgroundColor: Colors.black.withOpacity(0.5),
            ))),
      ],
    );
  }
}
