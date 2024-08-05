import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multisol/src/feature/auth/controllers/auth_controller.dart';
import 'package:multisol/src/feature/home/pages/home_page.dart';
import 'package:multisol/src/models/user_model.dart';
import 'package:multisol/src/widgets/full_size_loading_indicator.dart';

import 'constants/admin_email.dart';
import 'feature/admin/pages/admin_page.dart';
import 'feature/auth/pages/signup_page.dart';
import 'feature/auth/pages/welcome_page.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return FutureBuilder<UserModel?>(
              future: controller.loginUser(user.data!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const FullSizeLoadingIndicator();
                } else {
                  return Obx(
                    () {
                      if (controller.user.value.uid != null) {
                        //받은 컨트롤러의 유저 데이터가 이미 있을경우 앱으로, 아니면 회원가입창으로
                        if (user.data!.email == AdminEmail.adminEmail) {
                          return const AdminPage();
                        } else if (!controller.user.value.isSubmit!) {
                          return const HomePage();
                        } else {
                          // 이미 주문한 상황일경우
                          return const HomePage();
                        }
                      } else {
                        return SignupPage(
                          uid: user.data!.uid,
                          email: user.data!.email!,
                        );
                      }
                    },
                  );
                  // : SignupPage(uid: user.data!.uid));
                }
              });
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
