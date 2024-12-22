import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/controllers/admin_file_upload_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/widgets/main_button.dart';
import 'package:multisol/src/widgets/title_text.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/full_size_loading_indicator.dart';

class AdminFileUploadPage extends GetView<AdminFileUploadPageController> {
  FootModel footModel;

  AdminFileUploadPage({
    Key? key,
    required this.footModel,
  }) : super(key: key);

  Widget _uploadButton() {
    return MainButton(
      buttonText: '파일 업로드(.glb .gltf)',
      onTap: () {
        controller.uploadFile(footModel);
      },
    );
  }

  Widget _orderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '성함 : ${footModel.name.toString()}\n'
                '주문번호 : ${footModel.footId.toString().substring(0, 13)}\n'
                '유저 ID : ${footModel.uid.toString()}\n'
                '연락처 : ${footModel.contact.toString()}\n'
                'email : ${footModel.email.toString()}\n'
                '키 : ${footModel.height.toString()}\n'
                '몸무게 : ${footModel.weight.toString()}\n'
                '특이사항 : ${footModel.description.toString()}\n'
                '체형 : ${footModel.body.toString()}\n'
                '추가요청 : ${footModel.addition.toString()}\n'
                '주문인 : ${footModel.deliverName.toString()}\n'
                '배송연락처 : ${footModel.deliverContact.toString()}\n'
                '우편번호 : ${footModel.postCode.toString()}\n'
                '주소 : ${footModel.address.toString()}\n'
                '상세주소 : ${footModel.additionAddress.toString()}\n'
                '배송 요청사항 : ${footModel.request.toString()}\n'
                '검사일 : ${footModel.createdAt.toString()}\n'
                '주문일 : ${footModel.updatedAt.toString()}\n',
                style: TextStyle(
                  color: CustomColors.blackText,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _deliverButton() {
    return MainButton(
      buttonText: '배송 시작',
      onTap: () {
        controller.deliverStart(footModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AdminFileUploadPageController());
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: TitleText(text: '파일 업로드'),
          ),
          body: Column(
            children: [
              _uploadButton(),
              Expanded(child: _orderInfo()),
              _deliverButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoading.value,
            child: FullSizeLoadingIndicator(
              backgroundColor: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
