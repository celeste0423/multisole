import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<UserModel> user = UserModel().obs;

  Future<UserModel?> loginUser(String uid) async {
    UserModel? userData = await UserRepository.getUserData(uid);
    if (userData != null) {
      //authcontroller user 업데이트
      user(userData);
      // InitBinding.additionalBinding();
    }
    return userData;
  }

  Future<void> updateUserModel(UserModel userModel) async {
    user(userModel);
    await UserRepository().updateUserModel(userModel);
  }

  //구글 로그인
  Future<UserCredential> signInWithGoogle() async {
    return await UserRepository.signInWithGoogle();
  }

  //게스트 로그인
  Future signInWithGuest(String email, String password) async {
    await UserRepository().signUpWithEmailAndPassword(email, password);
  }

  //회원가입
  Future<void> signUp(UserModel userData) async {
    await UserRepository.signup(userData);
    await loginUser(userData.uid!);
    // print('uid야 ${user.value.uid}');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    user();
  }
}
