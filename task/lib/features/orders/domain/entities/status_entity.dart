class StatusEntity {
  final DataEntity data;
  final ResultEntity result;

  StatusEntity({
    required this.data,
    required this.result,
  });

}

class DataEntity {
  final List<DeliveryStatusTypeEntity> deliveryStatusTypes;

  DataEntity({
    required this.deliveryStatusTypes,
  });

}

class DeliveryStatusTypeEntity {
  final String typNm;
  final String typNo;

  DeliveryStatusTypeEntity({
    required this.typNm,
    required this.typNo,
  });

}

class ResultEntity {
  final String errMsg;
  final int errNo;

  ResultEntity({
    required this.errMsg,
    required this.errNo,
  });

}
