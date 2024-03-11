import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/orders/presentation/manager/orders_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/font_details.dart';
import '../../../../shared_widgets/custom_text.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget(
      {super.key,
      required this.status,
      required this.totalPrice,
      required this.date,
      required this.orderId,
      required this.statusColor});

  final String orderId;
  final String status;
  final Color statusColor;
  final String totalPrice;
  final String date;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        OrdersCubit ordersCubit = OrdersCubit.get(context);
        return Container(
          height: 90.w,
          width: 340.w,
          margin: EdgeInsets.only(left: 15.w, bottom: 15.w, right: 15.w),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(3, 3))
            ],
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: CustomTextWidget(
                          text: orderId,
                          textStyle: Theme.of(context).textTheme.bodySmall),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 250.w,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextWidget(
                                      text: 'Status',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  CustomTextWidget(
                                      text: status,
                                      textStyle: TextStyle(
                                        color: statusColor,
                                        fontSize: FontDetails.fontSizeS,
                                        fontWeight:
                                            FontDetails.semiBoldFontWeight,
                                      )),
                                ],
                              ),
                            ),
                            VerticalDivider(
                                color: AppColors.secondColor, thickness: 2),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextWidget(
                                      text: 'Total price',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  CustomTextWidget(
                                      text: '$totalPrice LE',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ],
                              ),
                            ),
                            VerticalDivider(
                                color: AppColors.secondColor, thickness: 2),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextWidget(
                                      text: 'Date',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  CustomTextWidget(
                                      text: date,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8.r),
                      topRight: Radius.circular(8.r)),
                  color: statusColor,
                ),
                width: 60.w,
                padding: EdgeInsets.all(5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextWidget(
                      text: 'Order Details',
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: AppColors.white, size: 15.w)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
