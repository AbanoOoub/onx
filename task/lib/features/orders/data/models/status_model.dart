import '../../domain/entities/status_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    required super.data,
    required super.result,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        data: Data.fromJson(json["Data"]),
        result: Result.fromJson(json["Result"]),
      );
}

class Data extends DataEntity {
  Data({
    required super.deliveryStatusTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deliveryStatusTypes: List<DeliveryStatusType>.from(
            json["DeliveryStatusTypes"]
                .map((x) => DeliveryStatusType.fromJson(x))),
      );
}

class DeliveryStatusType extends DeliveryStatusTypeEntity {
  DeliveryStatusType({
    required super.typNm,
    required super.typNo,
  });

  factory DeliveryStatusType.fromJson(Map<String, dynamic> json) =>
      DeliveryStatusType(
        typNm: json["TYP_NM"],
        typNo: json["TYP_NO"],
      );

  Map<String, dynamic> toJson() => {
        "TYP_NM": typNm,
        "TYP_NO": typNo,
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
