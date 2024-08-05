import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/custom_color.dart';

Widget loadingIndicator() {
  return LoadingAnimationWidget.fourRotatingDots(
    color: CustomColors.mainOrange,
    size: 50,
  );
}
