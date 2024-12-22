import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/foot_list/controllers/foot_list_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/utils/foot_utils.dart';
import 'package:multisol/src/widgets/full_size_loading_indicator.dart';

import '../../../utils/custom_color.dart';
import '../../../widgets/title_text.dart';

class FootListPage extends GetView<FootListPageController> {
  const FootListPage({super.key});

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      title: TitleText(
        text: '신청 목록',
      ),
    );
  }

  Widget _footList() {
    return StreamBuilder<List<FootModel>>(
      stream: controller.footModelListStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return FullSizeLoadingIndicator(
            backgroundColor: Colors.transparent,
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
    return Opacity(
      opacity: footModel.isCompleted! == 0 ? 0.3 : 1,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      '${footModel.createdAt.toString().substring(0, 10)} 검사',
                      style: TextStyle(
                        color: CustomColors.blackText,
                        fontSize: 22,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FootListPageController());
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _footList(),
      ),
    );
  }
}
