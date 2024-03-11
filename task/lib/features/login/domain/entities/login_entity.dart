class LoginEntity {
  final DataEntity data;
  final ResultEntity result;

  LoginEntity({
    required this.data,
    required this.result,
  });

}

class DataEntity {
  final String? deliveryName;

  DataEntity({
    required this.deliveryName,
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
