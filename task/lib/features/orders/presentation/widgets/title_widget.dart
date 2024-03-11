import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/language/presentation/widgets/select_lang_dialog.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../shared_widgets/custom_text.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.red,
      width: double.infinity,
      height: 130.w,
      padding: EdgeInsets.only(left: 15.w),
      margin: EdgeInsets.only(bottom: 20.w),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: CustomTextWidget(
                  text: userName,
                  maxLines: 3,
                  textStyle: Theme.of(context).textTheme.headlineLarge),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppImages.showImg(
                        height: 130.w, imgPath: AppImages.blueCircleImg),
                  ),
                  Positioned(
                      right: 50.w,
                      height: 130.w,
                      child:
                          AppImages.showImg(imgPath: AppImages.deliveryManImg)),
                  Positioned(
                    right: 20.w,
                    top: 30.w,
                    width: 20.w,
                    height: 20.w,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const SelectLangDialogWidget();
                          },
                        );
                      },
                      child: AppImages.showImg(imgPath: AppImages.languageImg),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
