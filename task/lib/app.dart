import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/config/routes/app_routes.dart';
import 'package:task/config/themes/app_theme.dart';
import 'package:task/core/app_constants/local_keys.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Task',
          theme: appTheme(),
          initialRoute:
              di.sl<SharedPreferences>().getBool(AppLocalKey.isLoggedInKey) ==
                          null ||
                      false
                  ? AppRoutes.loginScreenRoute
                  : AppRoutes.ordersScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
