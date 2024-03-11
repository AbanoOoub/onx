import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../shared_widgets/custom_text.dart';

class EmptyOrdersWidget extends StatelessWidget {
  const EmptyOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppImages.showImg(imgPath: AppImages.emptyOrderImg),
        SizedBox(height: 10.w),
        CustomTextWidget(
            text: 'No orders yet',
            textStyle: Theme.of(context).textTheme.displayLarge),
        SizedBox(
            width: 280.w,
            child: CustomTextWidget(
                text: 'You don\'t have any orders in your history',
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.displaySmall)),
      ],
    );
  }
}
