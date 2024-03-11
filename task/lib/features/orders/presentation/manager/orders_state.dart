part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class ChangeScreenTypeState extends OrdersState {}

class GetOrdersLoadingState extends OrdersState {}

class GetOrdersSuccessState extends OrdersState {
  final OrdersEntity ordersEntity;

  GetOrdersSuccessState({required this.ordersEntity});
}

class GetOrdersErrorState extends OrdersState {
  final String msg;

  GetOrdersErrorState({required this.msg});
}

class GetOrderStatusSuccessState extends OrdersState {
  final StatusEntity statusEntity;

  GetOrderStatusSuccessState({required this.statusEntity});
}

class GetOrderStatusErrorState extends OrdersState {
  final String msg;

  GetOrderStatusErrorState({required this.msg});
}
