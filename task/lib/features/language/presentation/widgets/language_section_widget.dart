import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/shared_widgets/custom_text.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';

class LanguageSectionWidget extends StatelessWidget {
  const LanguageSectionWidget(
      {super.key,
      required this.langTitle,
      required this.langSubTitle,
      required this.langImg,
      required this.isSelectedLang});

  final String langTitle;
  final String langSubTitle;
  final String langImg;
  final bool isSelectedLang;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      width: 140.w,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: isSelectedLang ? AppColors.selectionLangColor : AppColors.white,
        border: Border.all(color: AppColors.secondColor, width: 2.w),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImages.showImg(imgPath: langImg, width: 30.w, height: 30.w),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: langTitle,
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                CustomTextWidget(
                    text: langSubTitle,
                    textStyle: Theme.of(context).textTheme.titleSmall),
              ]),
        ],
      ),
    );
  }
}
