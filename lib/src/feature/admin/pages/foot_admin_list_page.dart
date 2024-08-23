import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/controllers/foot_admin_list_page_controller.dart';

import '../../../models/foot_model.dart';
import '../../../repositories/foot_repository.dart';
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
        child: Text(
          footModel.createdAt.toString(),
          style: TextStyle(
            color: footModel.isCompleted == 0 ? Colors.red : Colors.grey,
            fontSize: 35,
          ),
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
