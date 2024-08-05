import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:multisol/src/binding/init_binding.dart';
import 'package:multisol/src/root.dart';
import 'package:multisol/src/theme/base_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //파이어베이스 설정
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //날짜 언어 세팅
  initializeDateFormatting('ko-KR');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      initialBinding: InitBinding(),
      title: 'MultiSole',
      theme: baseTheme(context),
      home: const Root(),
    );
  }
}
