import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/app_constants/local_keys.dart';
import 'package:task/core/enums/orders_screen_type_enum.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/orders/presentation/manager/orders_cubit.dart';
import 'package:task/features/orders/presentation/widgets/empty_orders_widget.dart';
import 'package:task/features/orders/presentation/widgets/order_details_widget.dart';
import 'package:task/features/orders/presentation/widgets/title_widget.dart';
import 'package:task/shared_widgets/custom_text.dart';
import 'package:task/injection_container.dart' as di;
import '../../../../core/utils/font_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<OrdersCubit>()..init(),
      child: Scaffold(
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            OrdersCubit ordersCubit = OrdersCubit.get(context);
            if (state is GetOrdersErrorState) {
              return RefreshIndicator(
                onRefresh: () async => ordersCubit.init(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleWidget(
                        userName: di
                            .sl<SharedPreferences>()
                            .getString(AppLocalKey.userNameKey)!),
                    Expanded(
                        child: Center(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                color: AppColors.error, size: 40.w),
                            SizedBox(height: 10.w),
                            CustomTextWidget(
                              text: 'Something went wrong \n ${state.msg}',
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                  fontSize: FontDetails.fontSizeM,
                                  fontWeight: FontDetails.mediumFontWeight,
                                  color: AppColors.error.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              );
            }
            if (state is GetOrdersSuccessState) {
              return RefreshIndicator(
                onRefresh: () async => ordersCubit.init(),
                child: Column(
                  children: [
                    TitleWidget(
                        userName: di
                            .sl<SharedPreferences>()
                            .getString(AppLocalKey.userNameKey)!),
                    Container(
                      width: 220.w,
                      height: 40.w,
                      margin: EdgeInsets.only(bottom: 30.w),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 5))
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18.r)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => ordersCubit.changeScreenType(
                                type: ScreenTypeEnum.newOrders),
                            child: Container(
                              width: 110.w,
                              height: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ordersCubit.selectedScreenType ==
                                        ScreenTypeEnum.newOrders
                                    ? AppColors.mainColor
                                    : AppColors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18.r)),
                              ),
                              child: CustomTextWidget(
                                  text: 'New',
                                  textStyle: ordersCubit.selectedScreenType ==
                                          ScreenTypeEnum.newOrders
                                      ? Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                      : Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                            ),
                          ),
                          InkWell(
                            onTap: () => ordersCubit.changeScreenType(
                                type: ScreenTypeEnum.others),
                            child: Container(
                              width: 110.w,
                              height: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ordersCubit.selectedScreenType ==
                                        ScreenTypeEnum.others
                                    ? AppColors.mainColor
                                    : AppColors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18.r)),
                              ),
                              child: CustomTextWidget(
                                  text: 'Others',
                                  textStyle: ordersCubit.selectedScreenType ==
                                          ScreenTypeEnum.others
                                      ? Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                      : Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.ordersEntity.data.deliveryBills.isEmpty) ...[
                      const Expanded(child: EmptyOrdersWidget()),
                    ] else ...[
                      Expanded(
                          child: ListView.builder(
                        itemCount: state.ordersEntity.data.deliveryBills.length,
                        itemBuilder: (context, index) {
                          return OrderDetailsWidget(
                              status: ordersCubit.getStatusName(
                                  statusFlg: state.ordersEntity.data
                                      .deliveryBills[index].dlvryStatusFlg),
                              statusColor: ordersCubit.getStatusColor(
                                  statusFlg: state.ordersEntity.data
                                      .deliveryBills[index].dlvryStatusFlg),
                              totalPrice: double.parse(state.ordersEntity.data
                                      .deliveryBills[index].billAmt)
                                  .toStringAsFixed(2),
                              date: state.ordersEntity.data.deliveryBills[index]
                                  .billDate,
                              orderId: state.ordersEntity.data
                                  .deliveryBills[index].billSrl);
                        },
                      )),
                    ]
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  TitleWidget(
                      userName: di
                          .sl<SharedPreferences>()
                          .getString(AppLocalKey.userNameKey)!),
                  Container(
                    width: 220.w,
                    height: 40.w,
                    margin: EdgeInsets.only(bottom: 30.w),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 5))
                      ],
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18.r)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => ordersCubit.changeScreenType(
                              type: ScreenTypeEnum.newOrders),
                          child: Container(
                            width: 110.w,
                            height: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ordersCubit.selectedScreenType ==
                                      ScreenTypeEnum.newOrders
                                  ? AppColors.mainColor
                                  : AppColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18.r)),
                            ),
                            child: CustomTextWidget(
                                text: 'New',
                                textStyle: ordersCubit.selectedScreenType ==
                                        ScreenTypeEnum.newOrders
                                    ? Theme.of(context).textTheme.headlineMedium
                                    : Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                          ),
                        ),
                        InkWell(
                          onTap: () => ordersCubit.changeScreenType(
                              type: ScreenTypeEnum.others),
                          child: Container(
                            width: 110.w,
                            height: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ordersCubit.selectedScreenType ==
                                      ScreenTypeEnum.others
                                  ? AppColors.mainColor
                                  : AppColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18.r)),
                            ),
                            child: CustomTextWidget(
                                text: 'Others',
                                textStyle: ordersCubit.selectedScreenType ==
                                        ScreenTypeEnum.others
                                    ? Theme.of(context).textTheme.headlineMedium
                                    : Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child: CircularProgressIndicator.adaptive(
                          backgroundColor: AppColors.mainColor)),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
