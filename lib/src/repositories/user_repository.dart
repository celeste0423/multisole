import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as google;

import '../feature/auth/controllers/auth_controller.dart';
import '../helpers/open_alert_dialog.dart';
import '../models/user_model.dart';

class UserRepository {
  //구글 로그인
  static Future<UserCredential> signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final google.GoogleSignIn googleSignIn = google.GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    // final GoogleSignIn googleSignIn = GoogleSignIn(
    //     scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"]);
    //구글 로그인 페이지 표시
    final google.GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return openAlertDialog(title: '로그인 정보가 없습니다.');
    }
    //로그인 성공, 유저정보 가져오기
    final google.GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    //print('(user repo) idtoken ${googleAuth.idToken}');
    //print('(user repo) accesstoken ${googleAuth.accessToken}');
    //파이어베이스 인증 정보 로그인
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('(user repo) credential $credential');
    return await auth.signInWithCredential(credential);
  }

  //게스트 로그인
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      print('게스트 회원가입 시작, ${email} ${password}');
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('크레덴셜 받아옴');
      if (userCredential.user != null) {
        // 로그인 성공 시 처리
      } else {
        // 로그인 실패 시 처리
        //print('Login failed');
      }
    } catch (e) {
      //print(e.toString());
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // 등록된 사용자 없음 -> 회원가입으로 처리
          try {
            print('게스트 회원가입');
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
            // 회원가입 성공 시 처리
          } catch (e) {
            // 회원가입 실패 시 처리
            print('Error during sign up: $e');
          }
        } else {
          // 다른 에러 처리
          //print('Error: $e');
        }
      }
    }
  }

  static Future<UserModel?> getUserData(String uid) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    // print('유저 로그인 완료');
    if (data.size == 0) {
      print('데이터 없음');
      return null;
    } else {
      //데이터 있음
      print(data.docs.first.data());
      return UserModel.fromJson(data.docs.first.data());
    }
  }

  Future<void> updateUserModel(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .update(userModel.toJson());
    } catch (e) {
      openAlertDialog(title: '유저 모델 업데이트 중 오류 발생', content: e.toString());
    }
  }

  static Future<void> signup(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());
    } catch (e) {
      openAlertDialog(title: '회원가입에 실패했습니다', content: e.toString());
    }
  }

  static Future signOut() async {
    try {
      //이전 로그인 기록 지우기
      //todo: 해보니까 이전 로그인 기록 지워지지 않은것 같은데 그럼 왜 await googleSignIn.signOut();가 필요한거지?일단 앱 돌아가는데 아무 문제 없으니 스킵.
      try {
        final google.GoogleSignIn googleSignIn = google.GoogleSignIn();
        await googleSignIn.signOut();
      } catch (e) {
        openAlertDialog(title: e.toString());
      }
      await FirebaseAuth.instance.signOut();
      // AuthController.to.clearAuthController();
      print(
          "로그아웃 성공! AuthController.to.user.value.email = ${AuthController.to.user.value.email}");
    } catch (e) {
      print('로그아웃 실패${e.toString()}');
    }
  }

  Future deleteUserModel(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .delete();
    } catch (e) {
      openAlertDialog(
          title: '계정 삭제에 실패했습니다. 에러메시지를 신고해주세요.', content: e.toString());
    }
  }
}
