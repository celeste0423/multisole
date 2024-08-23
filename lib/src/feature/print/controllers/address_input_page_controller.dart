import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/print/pages/pay_page.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/repositories/foot_repository.dart';

import '../../../helpers/open_alert_dialog.dart';

class AddressInputPageController extends GetxController {
  Rx<bool> isLoading = false.obs;

  TextEditingController deliverNameController = TextEditingController();
  TextEditingController deliverContactController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController additionAddressController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  void payButton(FootModel footModel) {
    FocusScope.of(Get.context!).unfocus();
    isLoading(true);
    if (deliverNameController.text == '') {
      isLoading(false);
      openAlertDialog(title: '수령인을 입력해주세요');
    } else if (deliverContactController.text == '') {
      isLoading(false);
      openAlertDialog(title: '수령인 전환번호를 입력해주세요');
    } else if (postCodeController.text == '') {
      isLoading(false);
      openAlertDialog(title: '우편번호를 입력해주세요');
    } else if (addressController.text == '') {
      isLoading(false);
      openAlertDialog(title: '주소를 입력해주세요');
    } else if (additionAddressController.text == '') {
      isLoading(false);
      openAlertDialog(title: '상세주소를 입력해주세요');
    } else {
      FootModel updatedFootModel = footModel.copyWith(
        deliverName: deliverNameController.text,
        deliverContact: deliverContactController.text,
        postCode: int.parse(postCodeController.text),
        address: addressController.text,
        additionAddress: additionAddressController.text,
        request: requestController.text,
        isCompleted: 2,
        updatedAt: DateTime.now(),
      );

      FootRepository().update(updatedFootModel);

      Get.to(() => PayPage());

      isLoading(false);
    }
  }
}
