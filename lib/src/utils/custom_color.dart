import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  //앱 대표 색 materialColor type
  static const MaterialColor mainBlueMaterial = MaterialColor(
    0xFF5FA3D4,
    <int, Color>{
      50: Color(0xFFE1EEF7),
      100: Color(0xFFB5D7F1),
      200: Color(0xFF89C1EB),
      300: Color(0xFF5CAAE4),
      400: Color(0xFF3B9CDE),
      500: Color(0xFF5FA3D4),
      600: Color(0xFF248FCC),
      700: Color(0xFF2184C4),
      800: Color(0xFF1D79BB),
      900: Color(0xFF1466AD),
    },
  );

  //앱 대표 색
  static const Color mainOrange = Color(0xFFE4743C);
  static const Color mainBlack = Color(0xFF20212D);

  //텍스트 색
  static const Color blackText = Color(0xFF171717);
  static const Color darkGreyText = Color(0xFF2F2F2F);
  static const Color greyText = Color(0xFF7C7C7C);
  static const Color lightGreyText = Color(0xFFA8A8A8);
  static const Color whiteText = Color(0xFFF6F6F6);
  static const Color redText = Color(0xFFF14B40);

  //배경 색
  static const Color whiteBackground = Color(0xFFFFFFFF);
  static const Color lightGreyBackground = Color(0xFFF1F1F1);
  static const Color greyBackground = Color(0xFFBBBBBB);
  // static const Color blueBackground = Color(0xFF5FA3D4);
}
