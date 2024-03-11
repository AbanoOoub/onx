import 'package:task/features/orders/domain/entities/orders_entity.dart';

class OrdersModel extends OrdersEntity {
  OrdersModel({
    required super.data,
    required super.result,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        data: Data.fromJson(json["Data"]),
        result: Result.fromJson(json["Result"]),
      );
}

class Data extends DataEntity {
  Data({
    required super.deliveryBills,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deliveryBills: List<DeliveryBill>.from(
            json["DeliveryBills"].map((x) => DeliveryBill.fromJson(x))),
      );
}

class DeliveryBill extends DeliveryBillEntity {
  DeliveryBill({
    required super.billAmt,
    required super.billDate,
    required super.billNo,
    required super.billSrl,
    required super.billTime,
    required super.billType,
    required super.cstmrAddrss,
    required super.cstmrAprtmntNo,
    required super.cstmrBuildNo,
    required super.cstmrFloorNo,
    required super.cstmrNm,
    required super.dlvryAmt,
    required super.dlvryStatusFlg,
    required super.latitude,
    required super.longitude,
    required super.mobileNo,
    required super.rgnNm,
    required super.taxAmt,
  });

  factory DeliveryBill.fromJson(Map<String, dynamic> json) => DeliveryBill(
        billAmt: json["BILL_AMT"],
        billDate: json["BILL_DATE"],
        billNo: json["BILL_NO"],
        billSrl: json["BILL_SRL"],
        billTime: json["BILL_TIME"],
        billType: json["BILL_TYPE"],
        cstmrAddrss: json["CSTMR_ADDRSS"],
        cstmrAprtmntNo: json["CSTMR_APRTMNT_NO"],
        cstmrBuildNo: json["CSTMR_BUILD_NO"],
        cstmrFloorNo: json["CSTMR_FLOOR_NO"],
        cstmrNm: json["CSTMR_NM"],
        dlvryAmt: json["DLVRY_AMT"],
        dlvryStatusFlg: json["DLVRY_STATUS_FLG"],
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
        mobileNo: json["MOBILE_NO"],
        rgnNm: json["RGN_NM"]!,
        taxAmt: json["TAX_AMT"],
      );

  Map<String, dynamic> toJson() => {
        "BILL_AMT": billAmt,
        "BILL_DATE": billDate,
        "BILL_NO": billNo,
        "BILL_SRL": billSrl,
        "BILL_TIME": billTime,
        "BILL_TYPE": billType,
        "CSTMR_ADDRSS": cstmrAddrss,
        "CSTMR_APRTMNT_NO": cstmrAprtmntNo,
        "CSTMR_BUILD_NO": cstmrBuildNo,
        "CSTMR_FLOOR_NO": cstmrFloorNo,
        "CSTMR_NM": cstmrNm,
        "DLVRY_AMT": dlvryAmt,
        "DLVRY_STATUS_FLG": dlvryStatusFlg,
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
        "MOBILE_NO": mobileNo,
        "RGN_NM": rgnNm,
        "TAX_AMT": taxAmt,
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
