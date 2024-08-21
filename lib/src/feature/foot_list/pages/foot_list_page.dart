import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/foot_list/controllers/foot_list_page_controller.dart';
import 'package:multisol/src/models/foot_model.dart';
import 'package:multisol/src/widgets/full_size_loading_indicator.dart';

import '../../../widgets/image_icon_button.dart';
import '../../home/pages/home_page.dart';

class FootListPage extends GetView<FootListPageController> {
  const FootListPage({super.key});

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
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        controller.footListTileButton(footModel);
      },
      child: Container(
        child: Text(
          footModel.createdAt.toString(),
          style: TextStyle(
            color: Colors.red,
            fontSize: 35,
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
        body: Column(
          children: [
            _appbar(),
            Expanded(child: _footList()),
          ],
        ),
      ),
    );
  }
}
