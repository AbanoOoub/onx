import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/usecases/usecase.dart';
import 'package:task/features/orders/domain/entities/orders_entity.dart';

import '../repositories/orders_repository.dart';

class GetOrdersUC implements UseCase<OrdersEntity, GetOrdersParams> {
  final OrdersRepository ordersRepository;

  GetOrdersUC({required this.ordersRepository});

  @override
  Future<Either<Failure, OrdersEntity>> call(GetOrdersParams params) {
    return ordersRepository.getOrders(params);
  }
}

class GetOrdersParams {
  final String pDlvryNo;
  final String pLangNo;
  final String pBillSrl;
  final String pPrcssdFlg;

  GetOrdersParams(
      {required this.pDlvryNo,
      required this.pLangNo,
      required this.pBillSrl,
      required this.pPrcssdFlg});
}
