import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import '../../model/proudct/proudct.dart';

class SearchState {
  var productPagingController = PagingController<int, Proudct>(
    firstPageKey: 1,
  ).obs;
  var valueKeyboard = false.obs;
  var textSearch = ''.obs;

  var switcher = true.obs;
  var showCart = false.obs;
  var isCheckPrice = false.obs;
}
