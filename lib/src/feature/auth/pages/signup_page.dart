import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/service_urls.dart';
import '../../../helpers/open_alert_dialog.dart';
import '../../../utils/custom_color.dart';
import '../../../widgets/full_size_loading_indicator.dart';
import '../../../widgets/image_icon_button.dart';
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

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: controller.isProfileEditing == null ? 140 : 75,
      leading: ImageIconButton(
        assetPath: 'assets/icons/back.svg',
        iconColor: Colors.white,
        onTap: Get.back,
      ),
    );
  }

  Widget _announcementText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.isProfileEditing == null ? '당신에 대해 알려주세요!' : '프로필 수정',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '해당 정보로 다양한 랭킹 배틀에 참여할 수 있습니다.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputTab() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - 240 < 520 ? 520 : Get.height - 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFieldBox(
                  textEditingController: controller.nicknameController,
                  backgroundColor: CustomColors.lightGreyBackground,
                  hintText: '닉네임(2~8자)',
                  maxLength: 8,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(Get.context!).unfocus(),
                  autoFocus: controller.isProfileEditing == null ? true : false,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.isProfileEditing == null
                        ? _termsAgreement()
                        : const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MainButton(
                        buttonText: '승부 시작 !',
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
        ),
      ),
    );
  }

  Widget _termsAgreement() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: CustomColors.greyText,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: '이용약관 ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Uri uri =
                              Uri.parse(ServiceUrls.serviceTermsNotionUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            openAlertDialog(title: '오류 발생');
                          }
                        },
                    ),
                    const TextSpan(text: '및 '),
                    TextSpan(
                      text: '개인정보처리방침',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Uri uri = Uri.parse(
                              ServiceUrls.personalInformationPolicyNotionUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            openAlertDialog(title: '오류 발생');
                          }
                        },
                    ),
                    const TextSpan(text: ' 동의'),
                  ],
                ),
              ),
              Obx(
                () => Checkbox(
                  value: controller.isTermAgreed.value,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (bool? newValue) {
                    controller.isTermAgreed(newValue);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    Get.put(SignupPageController());
    controller.uid(uid);
    controller.email(email);
    return Stack(
      children: [
        KeyboardDismissOnTap(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: CustomColors.mainOrange,
            appBar: _appBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(Get.context!).padding.top),
                _announcementText(),
                const SizedBox(height: 30),
                _inputTab(),
              ],
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
