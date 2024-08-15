import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/admin/pages/foot_admin_page.dart';

import '../../../repositories/user_repository.dart';
import '../../../widgets/main_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관리자 페이지'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              MainButton(
                buttonText: '발 모델 리스트',
                backgroundColor: Colors.grey,
                onTap: () {
                  Get.to(() => FootAdminPage());
                },
              ),
              MainButton(
                buttonText: '로그아웃',
                backgroundColor: Colors.red,
                onTap: () async {
                  await UserRepository.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
