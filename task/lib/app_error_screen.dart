import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/app_constants/arg_keys.dart';

import 'core/utils/app_colors.dart';
import 'core/utils/font_details.dart';
import 'shared_widgets/custom_text.dart';

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String?, String?> args =
        ModalRoute.of(context)!.settings.arguments as Map<String?, String?>;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: 40.w),
            SizedBox(height: 10.w),
            CustomTextWidget(
              text: 'Something went wrong \n ${args[AppArgKeys.errScreenMsgKey] ?? ''}',
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                  fontSize: FontDetails.fontSizeM,
                  fontWeight: FontDetails.mediumFontWeight,
                  color: AppColors.error.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
