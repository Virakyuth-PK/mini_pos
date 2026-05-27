import 'package:mini_pos/src/data/network/enum_end_point.dart';
import 'package:mini_pos/src/model/category_response/category_response.dart';

import '../../../core/config/network/api_handler.dart';
import '../../../core/config/network/paging.dart';
import '../../model/proudct/proudct.dart';
import '../network/api_endpoint.dart';

abstract class IProductRepo {
  Future<Paging<Proudct>?> getAllProductPriceChecking({
    int? pageNo,
    int? pageSize,
    String? storeId,
  });

  Future<Paging<CategoryResponse>?> getCategory({
    int? pageNo,
    int? pageSize,
    String? storeId,
  });

  Future<Proudct?> getProductByBarcode(String barcode);
}

class ProductRepo implements IProductRepo {
  @override
  Future<Paging<Proudct>?> getAllProductPriceChecking({
    int? pageNo,
    int? pageSize,
    String? storeId,
    String? search,
  }) async {
    ApiHandler<Paging<Proudct>> handler = ApiHandler<Paging<Proudct>>.get(
      converter: (json) => Paging<Proudct>.fromMap(json, type: Proudct),
    );
    var result = await handler.executePaging<Proudct>(
      onComplete: (data) => data,
      // isAuthenticated: false,
      customApikeyTag: "A-API-KEY",
      customApikey: "CMRT-Super-Customer-Key:171f12d96dda63eae8a04c6c08602f05",
      queryParams: {
        "StoreId": storeId,
        "PageNo": "${pageNo ?? 1}",
        "PageSize": "${pageSize ?? 10}",
        "Search": search ?? "",
      },
      endPoint: ApiEndpoint.product(ProductEndpoint.Get_All),
    );
    result?.data?.removeWhere((element) => (element.thumbnailImage?.filePath??"") == "",);

    return result;
  }

  @override
  Future<Paging<CategoryResponse>?> getCategory({
    int? pageNo,
    int? pageSize,
    String? storeId,
  }) async {
    ApiHandler<Paging<CategoryResponse>> handler =
        ApiHandler<Paging<CategoryResponse>>.get(
          converter: (json) =>
              Paging<CategoryResponse>.fromMap(json, type: CategoryResponse),
        );
    var result = await handler.executePaging<CategoryResponse>(
      onComplete: (data) => data,
      // isAuthenticated: false,
      customApikeyTag: "A-API-KEY",
      customApikey: "CMRT-Super-Customer-Key:171f12d96dda63eae8a04c6c08602f05",
      queryParams: {
        "StoreId": storeId,
        "PageNo": "${pageNo ?? 1}",
        "PageSize": "${pageSize ?? 10}",
        "IsActive": "${true}",
      },
      endPoint: ApiEndpoint.product(ProductEndpoint.Get_All_Category),
    );

    return result;
  }

  @override
  Future<Proudct?> getProductByBarcode(String barcode) async {
    ApiHandler<Proudct> handler = ApiHandler<Proudct>.get(
      converter: (json) => Proudct.fromJson(json),
    );

    var result = await handler.execute(
      onComplete: (data) => data,
      customApikeyTag: "A-API-KEY",
      customApikey: "CMRT-Super-Customer-Key:171f12d96dda63eae8a04c6c08602f05",
      endPoint: ApiEndpoint.product(
        ProductEndpoint.Get_By_Id,
        storeId: '10017',
        barcode: barcode.toString(),
      ),
    );
    return result;
  }
}
