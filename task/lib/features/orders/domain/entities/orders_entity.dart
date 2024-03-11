class OrdersEntity {
  final DataEntity data;
  final ResultEntity result;

  OrdersEntity({
    required this.data,
    required this.result,
  });

}

class DataEntity {
   List<DeliveryBillEntity> deliveryBills;

  DataEntity({
    required this.deliveryBills,
  });

}

class DeliveryBillEntity {
  final String billAmt;
  final String billDate;
  final String billNo;
  final String billSrl;
  final String billTime;
  final String billType;
  final String cstmrAddrss;
  final String cstmrAprtmntNo;
  final String cstmrBuildNo;
  final String cstmrFloorNo;
  final String cstmrNm;
  final String dlvryAmt;
  final String dlvryStatusFlg;
  final String latitude;
  final String longitude;
  final String mobileNo;
  final String rgnNm;
  final String taxAmt;

  DeliveryBillEntity({
    required this.billAmt,
    required this.billDate,
    required this.billNo,
    required this.billSrl,
    required this.billTime,
    required this.billType,
    required this.cstmrAddrss,
    required this.cstmrAprtmntNo,
    required this.cstmrBuildNo,
    required this.cstmrFloorNo,
    required this.cstmrNm,
    required this.dlvryAmt,
    required this.dlvryStatusFlg,
    required this.latitude,
    required this.longitude,
    required this.mobileNo,
    required this.rgnNm,
    required this.taxAmt,
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
