import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multisol/src/feature/admin/controllers/foot_admin_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';

import '../../../helpers/open_alert_dialog.dart';
import '../../../utils/custom_color.dart';
import '../../../widgets/title_text.dart';

class FootAdminPage extends GetView<FootAdminPageController> {
  const FootAdminPage({super.key});

  Widget _diaryList() {
    return StreamBuilder(
      stream: controller.listByDateStreamController.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<FootModel>> footModels,
      ) {
        if (!footModels.hasData) {
          return Center(
            child: CircularProgressIndicator(color: CustomColors.mainOrange),
          );
        } else if (footModels.hasError) {
          openAlertDialog(title: '에러 발생');
        } else {
          final list = footModels.data!;
          // print('리스트 출력(buk page)${list.length}');
          if (list.isNotEmpty) {
            return ListView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: controller.listByDateScrollController,
              children: [
                Column(
                  children: List.generate(list.length, (index) {
                    final footModel = list[index];
                    return footTile(footModel);
                  }),
                ),
                SizedBox(height: 100),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(child: Text('아직 발 모델이 없습니다')),
            );
          }
        }
        return Center(child: Text('아직 발 모델이 없습니다'));
      },
    );
  }

  Widget footTile(FootModel footModel) {
    String createdString =
        DateFormat('yyyy-MM-dd').format(footModel.createdAt!);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => FootAdminPage(),
              arguments: footModel,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            height: 130,
            width: Get.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              border: Border.all(
                color: Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4, top: 1),
                      height: 85,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          //todo: 이건 뭐지
                          image: NetworkImage(footModel.frontImgUrl!),
                          //   image: CachedNetworkImageProvider(
                          //       diaryModel.imgUrlList!.isEmpty ? Constants.baseImageUrl:diaryModel.imgUrlList![0]),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(5, 5), // Offset(수평, 수직)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            footModel.footId ?? '',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      // BkText(
                      //   dateString,
                      //   style: TextStyle(fontSize: 13),
                      // ),
                      Text(
                        '만든날짜 : $createdString',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        footModel.uid!,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FootAdminPageController());
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: '발모델 나열',
        ),
      ),
      body: _diaryList(),
    );
  }
}
