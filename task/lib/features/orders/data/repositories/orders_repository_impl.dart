import 'package:dartz/dartz.dart';
import 'package:task/core/error/exceptions.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/features/orders/domain/entities/orders_entity.dart';
import 'package:task/features/orders/domain/entities/status_entity.dart';
import 'package:task/features/orders/domain/repositories/orders_repository.dart';
import 'package:task/features/orders/domain/use_cases/get_order_status_uc.dart';
import 'package:task/features/orders/domain/use_cases/get_orders_uc.dart';
import '../data_sources/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource ordersRemoteDataSource;

  OrdersRepositoryImpl(
      {
      required this.ordersRemoteDataSource});

  @override
  Future<Either<Failure, OrdersEntity>> getOrders(
      GetOrdersParams params) async {
      try {
        final ordersResponse = await ordersRemoteDataSource.getOrders(params);
        return Right(ordersResponse);
      } on ServerException {
        return Left(ServerFailure());
      }
  }

  @override
  Future<Either<Failure, StatusEntity>> getOrdersStatus(GetOrderStatusParams params)async {
      try {
        final statusResponse = await ordersRemoteDataSource.getOrderStatus(params);
        return Right(statusResponse);
      } on ServerException {
        return Left(ServerFailure());
      }

  }
}
