enum ScreenTypeEnum {
  newOrders,
  others,
}

abstract class ScreenTypeEnumHelper {
  static String getScreenTypeId({required ScreenTypeEnum type}) {
    switch (type) {
      case ScreenTypeEnum.newOrders:
        return '1';
      case ScreenTypeEnum.others:
        return '2';
    }
  }
}
