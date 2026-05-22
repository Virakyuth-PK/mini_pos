import '../../../flavors.dart';
import 'enum_end_point.dart';

class ApiEndpoint {
  static const String version = "1";
  static const String suffix = "/api/v$version";

  //region Authentication
  static String product(ProductEndpoint endPoint) {
    var path = '${FConfig.baseUrl}$suffix/ItemPrice';
    switch (endPoint) {
      case ProductEndpoint.Get_All:
        return '$path/GetAllPriceChecking';
    }
  }
}
