import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/enums/orders_screen_type_enum.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/orders/domain/entities/orders_entity.dart';
import 'package:task/features/orders/domain/entities/status_entity.dart';

import '../../../../core/app_constants/local_keys.dart';
import '../../../../core/enums/lang_code_enum.dart';
import '../../domain/use_cases/get_order_status_uc.dart';
import '../../domain/use_cases/get_orders_uc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUC getOrdersUC;
  final GetOrderStatusUC getOrderStatusUC;
  final SharedPreferences sharedPreferences;

  OrdersCubit(
      {required this.sharedPreferences,
      required this.getOrderStatusUC,
      required this.getOrdersUC})
      : super(OrdersInitial());

  static OrdersCubit get(context) => BlocProvider.of(context);

  ScreenTypeEnum selectedScreenType = ScreenTypeEnum.newOrders;

  late OrdersEntity currOrdersEntity;
  late StatusEntity statusEntity;

  List<DeliveryBillEntity> allBillList = [];

  void init() {
    getOrderStatus().then((value) {
      getOrders();
    });
  }

  Future<void> getOrders() async {
    emit(GetOrdersLoadingState());
    final String langCode = sharedPreferences.getString(AppLocalKey.langKey)!;
    final String userNumber =
        sharedPreferences.getString(AppLocalKey.userNumberKey)!;

    Either<Failure, OrdersEntity> response = await getOrdersUC(GetOrdersParams(
        pDlvryNo: userNumber,
        pLangNo: LangCodeEnumHelper.getLangCodeId(code: langCode).toString(),
        pBillSrl: "",
        pPrcssdFlg: ""));

    emit(response.fold(
        (failure) => GetOrdersErrorState(msg: failure.mapFailureToMsg(failure)),
        (ordersEntity) {
      currOrdersEntity = ordersEntity;
      allBillList.clear();
      for (var element in ordersEntity.data.deliveryBills) {
        allBillList.add(element);
      }
      // to filter new orders only
      currOrdersEntity.data.deliveryBills.clear();
      currOrdersEntity.data.deliveryBills = allBillList.where((element) {
        // when refresh and user on others tab
        if (selectedScreenType == ScreenTypeEnum.newOrders) {
          return element.dlvryStatusFlg == '0';
        }
        return element.dlvryStatusFlg != '0';
      }).toList();

      return GetOrdersSuccessState(ordersEntity: currOrdersEntity);
    }));
  }

  Future<void> getOrderStatus() async {
    emit(GetOrdersLoadingState());
    final String langCode = sharedPreferences.getString(AppLocalKey.langKey)!;
    Either<Failure, StatusEntity> response =
        await getOrderStatusUC(GetOrderStatusParams(
      pLangNo: LangCodeEnumHelper.getLangCodeId(code: langCode).toString(),
    ));
    emit(response.fold(
        (failure) => GetOrdersErrorState(msg: failure.mapFailureToMsg(failure)),
        (statusEntity) {
      this.statusEntity = statusEntity;
      return GetOrderStatusSuccessState(statusEntity: statusEntity);
    }));
  }

  void changeScreenType({required ScreenTypeEnum type}) {
    selectedScreenType = type;
    currOrdersEntity.data.deliveryBills.clear();
    if (type == ScreenTypeEnum.newOrders) {
      for (var element in allBillList) {
        if (element.dlvryStatusFlg == '0') {
          currOrdersEntity.data.deliveryBills.add(element);
        }
      }
    } else {
      for (var element in allBillList) {
        if (element.dlvryStatusFlg != '0') {
          currOrdersEntity.data.deliveryBills.add(element);
        }
      }
    }
    emit(GetOrdersSuccessState(ordersEntity: currOrdersEntity));
  }

  Color getStatusColor({required String statusFlg}) {
    for (var element in statusEntity.data.deliveryStatusTypes) {
      if (statusFlg == element.typNo) {
        switch (element.typNo) {
          case '1':
            return AppColors.deliveredOrderColor;
          case '2':
            return AppColors.partialReturnOrderColor;
          case '3':
            return AppColors.returnedOrderColor;
        }
      }
    }
    return AppColors.green;
  }

  String getStatusName({required String statusFlg}) {
    for (var element in statusEntity.data.deliveryStatusTypes) {
      if (statusFlg == element.typNo) {
        return element.typNm;
      }
    }
    return 'New';
  }
}
