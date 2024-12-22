import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/widgets/main_button.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/full_size_loading_indicator.dart';
import '../../../widgets/title_text.dart';
import '../controllers/foot_image_add_controller.dart';

class FootImageAddPage extends GetView<FootImageAddController> {
  const FootImageAddPage({super.key});

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      title: TitleText(
        text: '사진 등록',
      ),
    );
  }

  Widget _imageBox() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  '발 정면 사진',
                  style: TextStyle(
                      color: CustomColors.blackText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            _imageView(true),
            const SizedBox(height: 15),
            const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  '발 측면 사진',
                  style: TextStyle(
                    color: CustomColors.blackText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            _imageView(false),
          ],
        ),
      ),
    );
  }

  Widget _imageView(bool isFront) {
    return Expanded(
      child: Obx(
        () => isFront
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: controller.uploadFrontImage,
                child: controller.frontImgUrl.value != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          controller.frontImgUrl.value!,
                          fit: BoxFit.cover,
                          width: Get.width - 20,
                        ),
                      )
                    : Container(
                        width: Get.width - 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CustomColors.mainBlack,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/front.png',
                              height: 100,
                            ),
                            Text(
                              '정면 사진 업로드 +',
                              style:
                                  TextStyle(color: CustomColors.lightGreyText),
                            )
                          ],
                        ),
                      ),
              )
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: controller.uploadSideImage,
                child: controller.sideImgUrl.value != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          controller.sideImgUrl.value!,
                          fit: BoxFit.cover,
                          width: Get.width - 20,
                        ),
                      )
                    : Container(
                        width: Get.width - 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CustomColors.mainBlack,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/side.png',
                              height: 100,
                            ),
                            Text(
                              '측면 사진 업로드 +',
                              style:
                                  TextStyle(color: CustomColors.lightGreyText),
                            )
                          ],
                        ),
                      ),
              ),
      ),
    );
  }

  Widget _buttonBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 40),
      child: Column(
        children: [
          SizedBox(height: 15),
          MainButton(
            buttonText: 'AI 분석 시작 >',
            onTap: controller.uploadButton,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FootImageAddController());
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _appBar(),
          body: SizedBox(
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: MediaQuery.of(Get.context!).padding.top),
                _imageBox(),
                _buttonBox(),
              ],
            ),
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
