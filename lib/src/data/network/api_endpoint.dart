import '../../../flavors.dart';
import 'enum_end_point.dart';

class ApiEndpoint {
  static const String version = "1";
  static const String suffix = "/api/v$version";

  static String product(
    ProductEndpoint endPoint, {
    String? storeId,
    String? barcode,
  }) {
    var path = '${FConfig.baseUrl}$suffix';
    switch (endPoint) {
      case ProductEndpoint.Get_All:
        return '$path/ItemPrice/GetAllPriceChecking';
      case ProductEndpoint.Get_All_Category:
        return '$path/MainCategory/GetAll';
      case ProductEndpoint.Get_By_Id:
        return '$path/ItemPrice/GetByBarcode/$storeId/$barcode';
    }
  }

  static String promotion(PromotionEndpoint endPoint) {
    var path = '${FConfig.baseUrl}$suffix';
    switch (endPoint) {
      case PromotionEndpoint.Get_All:
        return '$path/Article/GetAll';
    }
  }
}
