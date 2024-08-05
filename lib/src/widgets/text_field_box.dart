import 'package:flutter/material.dart';

import '../utils/custom_color.dart';

class TextFieldBox extends StatelessWidget {
  TextEditingController textEditingController;
  String? hintText;
  double? fontSize;
  double? height;
  int? maxLength;
  Color? backgroundColor;
  Color? textColor;
  Color? hintColor;
  Function()? suffixOnPressed;
  TextInputType? textInputType;
  Function(String)? onSubmitted;
  TextInputAction? textInputAction;
  bool? autoFocus;

  TextFieldBox({
    Key? key,
    required this.textEditingController,
    this.hintText,
    this.fontSize,
    this.height,
    this.maxLength,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.suffixOnPressed,
    this.textInputType,
    this.onSubmitted,
    this.textInputAction,
    this.autoFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText ?? '',
          style: TextStyle(
            fontSize: 10,
            color: CustomColors.whiteText,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: height ?? 50,
          child: TextField(
            maxLength: maxLength ?? 30,
            keyboardType: textInputType,
            controller: textEditingController,
            cursorColor: Colors.black.withOpacity(0.5),
            style: TextStyle(
              fontSize: fontSize ?? 14,
              color: CustomColors.blackText,
            ),
            decoration: InputDecoration(
              // hintText: hintText ?? '',
              // hintStyle: TextStyle(
              //   fontSize: fontSize ?? 14,
              //   color: CustomColors.lightGreyText,
              // ),
              counterText: '',
              border: InputBorder.none,
            ),
            onSubmitted: onSubmitted,
            textInputAction: textInputAction,
            autofocus: autoFocus ?? false,
          ),
        ),
      ],
    );
  }
}
