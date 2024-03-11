import 'package:task/core/api/api_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/features/orders/data/models/status_model.dart';
import 'package:task/features/orders/domain/use_cases/get_order_status_uc.dart';
import 'package:task/features/orders/domain/use_cases/get_orders_uc.dart';

import '../models/orders_model.dart';

abstract class OrdersRemoteDataSource {
  Future<OrdersModel> getOrders(GetOrdersParams params);

  Future<StatusModel> getOrderStatus(GetOrderStatusParams params);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiConsumer apiConsumer;

  OrdersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<OrdersModel> getOrders(GetOrdersParams params) async {
    final response =
        await apiConsumer.post(EndPoints.deliveryBillsItems, body: {
      "Value": {
        "P_DLVRY_NO": params.pDlvryNo,
        "P_LANG_NO": params.pLangNo,
        "P_BILL_SRL": params.pBillSrl,
        "P_PRCSSD_FLG": params.pPrcssdFlg
      }
    });
    return OrdersModel.fromJson(response);
  }

  @override
  Future<StatusModel> getOrderStatus(GetOrderStatusParams params) async {
    final response =
        await apiConsumer.post(EndPoints.deliveryStatusTypes, body: {
      "Value": {
        "P_LANG_NO": params.pLangNo,
      }
    });
    return StatusModel.fromJson(response);
  }
}
