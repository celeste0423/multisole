import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/widgets/main_button.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/full_size_loading_indicator.dart';
import '../../../widgets/image_icon_button.dart';
import '../../home/pages/home_page.dart';
import '../controllers/foot_image_add_controller.dart';

class FootImageAddPage extends GetView<FootImageAddController> {
  const FootImageAddPage({super.key});

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageIconButton(
          onTap: () {
            Get.back();
          },
          assetPath: 'assets/icons/back.png',
          height: 35,
          isPng: true,
        ),
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
          const EdgeInsets.only(left: 100, right: 100, bottom: 20, top: 20),
      child: Image.asset(
        'assets/images/logo.png',
        width: Get.width,
      ),
    );
  }

  Widget _imageBox() {
    return Expanded(
      child: Container(
        color: CustomColors.greyBackground,
        width: Get.width - 40,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _imageView(true),
            SizedBox(height: 15),
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
            ? controller.frontImgUrl.value != ''
                ? Image.network(
                    controller.frontImgUrl.value!,
                    fit: BoxFit.fill,
                  )
                : Container(
                    color: CustomColors.mainBlack,
                    width: Get.width - 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/front.png',
                          height: 100,
                        ),
                        Text(
                          '정면 사진 업로드 +',
                          style: TextStyle(color: CustomColors.lightGreyText),
                        )
                      ],
                    ),
                  )
            : controller.sideImgUrl.value != ''
                ? Image.network(controller.sideImgUrl.value!, fit: BoxFit.fill)
                : Container(
                    color: CustomColors.mainBlack,
                    width: Get.width - 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/side.png',
                          height: 100,
                        ),
                        Text(
                          '측면 사진 업로드 +',
                          style: TextStyle(color: CustomColors.lightGreyText),
                        )
                      ],
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
          Row(
            children: [
              Expanded(
                child: MainButton(
                  buttonText: '정면 사진 업로드 >',
                  onTap: controller.uploadFrontImage,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: MainButton(
                  buttonText: '측면 사진 업로드 >',
                  onTap: controller.uploadSideImage,
                ),
              ),
            ],
          ),
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
          backgroundColor: CustomColors.mainBlack,
          body: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: MediaQuery.of(Get.context!).padding.top),
                  _appbar(),
                  _logoBox(),
                  _imageBox(),
                  _buttonBox(),
                ],
              ),
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
