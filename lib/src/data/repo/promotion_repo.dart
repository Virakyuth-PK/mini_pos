import '../../../core/config/network/api_handler.dart';
import '../../../core/config/network/paging.dart';
import '../../model/promotion_response/promotion_response.dart';
import '../network/api_endpoint.dart';
import '../network/enum_end_point.dart';

abstract class IPromotionRepo {
  Future<Paging<PromotionResponse>?> getPromotionBanner({
    int? pageNo,
    int? pageSize,
    String? storeId,
  });
}

class PromotionRepo implements IPromotionRepo {
  @override
  Future<Paging<PromotionResponse>?> getPromotionBanner({
    int? pageNo,
    int? pageSize,
    String? storeId,
  }) async {
    ApiHandler<Paging<PromotionResponse>> handler =
        ApiHandler<Paging<PromotionResponse>>.get(
          converter: (json) =>
              Paging<PromotionResponse>.fromMap(json, type: PromotionResponse),
        );
    var result = await handler.executePaging<PromotionResponse>(
      onComplete: (data) => data,
      // isAuthenticated: false,
      customApikeyTag: "A-API-KEY",
      customApikey: "CMRT-Super-Customer-Key:171f12d96dda63eae8a04c6c08602f05",
      queryParams: {
        "StoreId": storeId,
        "PageNo": "${pageNo ?? 1}",
        "PageSize": "${pageSize ?? 10}",
      },
      endPoint: ApiEndpoint.promotion(PromotionEndpoint.Get_All),
    );

    return result;
  }
}
