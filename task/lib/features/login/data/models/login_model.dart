import 'package:task/features/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.data,
    required super.result,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: Data.fromJson(json["Data"]),
        result: Result.fromJson(json["Result"]),
      );
}

class Data extends DataEntity {
  Data({
    required super.deliveryName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deliveryName: json["DeliveryName"],
      );

  Map<String, dynamic> toJson() => {
        "DeliveryName": deliveryName,
      };
}

class Result extends ResultEntity {
  Result({
    required super.errMsg,
    required super.errNo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        errMsg: json["ErrMsg"],
        errNo: json["ErrNo"],
      );

  Map<String, dynamic> toJson() => {
        "ErrMsg": errMsg,
        "ErrNo": errNo,
      };
}
