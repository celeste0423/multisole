import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/controllers/address_input_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/full_size_loading_indicator.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_field_box.dart';
import '../../../widgets/title_text.dart';

class AddressInputPage extends GetView<AddressInputPageController> {
  FootModel footModel;

  AddressInputPage({required this.footModel, super.key});

  PreferredSizeWidget _appbar() {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      title: TitleText(
        text: '배송지 입력',
      ),
      backgroundColor: Colors.transparent,
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
            SizedBox(height: 20),
            TextFieldBox(
              textEditingController: controller.postCodeController,
              keyboardType: TextInputType.number,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '우편번호',
              maxLength: 5,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            SizedBox(height: 20),
            TextFieldBox(
              textEditingController: controller.addressController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '주소',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            SizedBox(height: 20),
            TextFieldBox(
              textEditingController: controller.additionAddressController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '상세주소',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            SizedBox(height: 20),
            TextFieldBox(
              textEditingController: controller.requestController,
              backgroundColor: CustomColors.lightGreyBackground,
              hintText: '배송 요청사항',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: MainButton(
                buttonText: '결제정보 선택하기',
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
            appBar: _appbar(),
            body: SingleChildScrollView(
              child: _inputTab(),
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
