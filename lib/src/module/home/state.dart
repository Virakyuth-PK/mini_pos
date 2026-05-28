import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mini_pos/src/model/category_response/category_response.dart';

import '../../model/proudct/proudct.dart';

class HomeState {
  var productPagingController = PagingController<int, Proudct>(
    firstPageKey: 1,
  ).obs;
  var categoryPagingController = PagingController<int, CategoryResponse>(
    firstPageKey: 1,
  ).obs;
  var isLoading = false.obs;
  var imageUrlList = <String>[];
  var currentIndex = 0.obs;
  var currentIndexSlide = 0.obs;
  var appVersion = "".obs;
}
