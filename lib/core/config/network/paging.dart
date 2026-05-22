import '../../../src/model/category_response/category_response.dart';
import '../../../src/model/promotion_response/promotion_response.dart';
import '../../../src/model/proudct/proudct.dart';

class Paging<T> {
  List<T>? data;
  int? pageNo;
  int? pageSize;
  int? totalPages;
  int? totalRecords;

  Paging({
    this.data,
    this.pageNo,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
  });

  @override
  String toString() {
    return 'Paging{data: $data, pageNo: $pageNo, pageSize: $pageSize, totalPages: $totalPages, totalRecords: $totalRecords}';
  }

  factory Paging.fromMap(Map<String, dynamic> data, {required Type type}) {
    return Paging(
      data: (data['data'] as List<dynamic>?)
          ?.map<T>((e) => factoryDataList(type, e) as T)
          .toList(),
      pageNo: data['pageNo'] as int?,
      pageSize: data['pageSize'] as int?,
      totalPages: data['totalPages'] as int?,
      totalRecords: data['totalRecords'] as int?,
    );
  }

  static final Map<Type, dynamic Function(Map<String, dynamic>)> _dataFactory =
      {
        Proudct: Proudct.fromJson,
        PromotionResponse: PromotionResponse.fromJson,
        CategoryResponse: CategoryResponse.fromJson,
      };

  static dynamic factoryDataList(Type type, dynamic data) {
    if (data is String || data is num || data is bool) {
      return data;
    }
    if (data is Map<String, dynamic>) {
      return _dataFactory[type]?.call(data);
    }
    return null;
  }
}
