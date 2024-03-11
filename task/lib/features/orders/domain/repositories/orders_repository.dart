import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/features/orders/domain/entities/status_entity.dart';
import 'package:task/features/orders/domain/use_cases/get_order_status_uc.dart';

import '../entities/orders_entity.dart';
import '../use_cases/get_orders_uc.dart';

abstract class OrdersRepository{
  Future<Either<Failure,OrdersEntity>> getOrders(GetOrdersParams params);
  Future<Either<Failure,StatusEntity>> getOrdersStatus(GetOrderStatusParams params);
}