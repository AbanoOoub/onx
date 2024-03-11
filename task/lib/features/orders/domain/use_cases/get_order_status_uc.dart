import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/usecases/usecase.dart';
import 'package:task/features/orders/domain/entities/orders_entity.dart';
import 'package:task/features/orders/domain/entities/status_entity.dart';

import '../repositories/orders_repository.dart';

class GetOrderStatusUC implements UseCase<StatusEntity, GetOrderStatusParams> {
  final OrdersRepository ordersRepository;

  GetOrderStatusUC({required this.ordersRepository});

  @override
  Future<Either<Failure, StatusEntity>> call(GetOrderStatusParams params) {
    return ordersRepository.getOrdersStatus(params);
  }
}

class GetOrderStatusParams {
  final String pLangNo;

  GetOrderStatusParams({
    required this.pLangNo,
  });
}
