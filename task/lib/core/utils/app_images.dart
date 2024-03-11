import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/core/utils/app_colors.dart';

class AppImages {
  static const String path = 'assets/images';
  static const String appLogoImg = '$path/onx_order_deliver.svg';
  static const String deliveryImg = '$path/delivery.svg';
  static const String languageImg = '$path/language.svg';
  static const String blueCircleImg = '$path/blue_circle.svg';
  static const String redCircleImg = '$path/red_circle.svg';
  static const String deliveryManImg = '$path/deliveryman.png';
  static const String emptyOrderImg = '$path/emptyorder.svg';
  static const String englishFlagImg = '$path/EnglishFlag.svg';
  static const String arabicFlagImg = '$path/ArabicFlag.svg';

  static Widget showImg({
    required String imgPath,
    double? width,
    double? height,
  }) {
    if (imgPath.endsWith('.svg')) {
      return SvgPicture.asset(imgPath, width: width, height: height);
    } else {
      return Image.asset(imgPath, width: width, height: height);
    }
  }
}
