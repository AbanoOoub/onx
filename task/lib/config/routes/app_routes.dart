import 'package:task/app_error_screen.dart';
import 'package:task/features/orders/presentation/screens/order_screen.dart';

import '../../features/login/presentation/screens/login_screen.dart';

class AppRoutes {
  static String loginScreenRoute = 'loginScreen';
  static String ordersScreen = 'ordersScreen';
  static String errorScreen = 'errorScreen';

  static get routes {
    return {
      AppRoutes.loginScreenRoute: (context) => const LoginScreen(),
      AppRoutes.ordersScreen: (context) => const OrdersScreen(),
      AppRoutes.errorScreen: (context) => const AppErrorScreen(),
    };
  }
}
