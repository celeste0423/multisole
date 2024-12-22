import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/controllers/foot_admin_list_page_controller.dart';

import '../../../models/foot_model.dart';
import '../../../repositories/foot_repository.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/foot_utils.dart';
import '../../../widgets/full_size_loading_indicator.dart';
import '../../../widgets/title_text.dart';

class FootAdminListPage extends GetView<FootAdminListPageController> {
  const FootAdminListPage({super.key});

  Widget _footList() {
    return StreamBuilder<List<FootModel>>(
      stream: controller.footModelListStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return GestureDetector(
            onTap: () async {
              await FootRepository()
                  .deleteFootModel('b22d8bc9-c418-4bbb-975a-02be1b4e7661');
              print('삭제 완료');
            },
            child: FullSizeLoadingIndicator(
              backgroundColor: Colors.transparent,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _footListTile(snapshot.data![index]);
            },
          );
        }
      },
    );
  }

  Widget _footListTile(FootModel footModel) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        controller.footListTileButton(footModel);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: CustomColors.mainGrey,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '성함 : ${footModel.name.toString()}',
                    style: TextStyle(
                      color: CustomColors.blackText,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '유저email : ${footModel.email.toString()}',
                    style: TextStyle(
                      color: CustomColors.blackText,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${footModel.createdAt.toString().substring(0, 10)} 검사',
                    style: TextStyle(
                      color: CustomColors.blackText,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '주문 번호 : ${footModel.footId.toString().substring(0, 13)}',
                    style: TextStyle(
                      color: CustomColors.greyText,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${FootUtils.orderStatus(footModel.isCompleted!)}',
                    style: TextStyle(
                      color: CustomColors.blackText,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FootAdminListPageController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TitleText(
            text: '발모델 나열',
          ),
        ),
        body: _footList(),
      ),
    );
  }
}
