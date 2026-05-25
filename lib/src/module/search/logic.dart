import 'dart:async';
import 'package:get/get.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';

import '../../../core/utils/x_paging_data_handler.dart';
import '../../model/proudct/proudct.dart';
import 'state.dart';

class SearchLogic extends GetxController {
  final ProductRepo _productRepo = Get.find();
  final SearchState state = SearchState();
  Timer? _debounceTimer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.productPagingController.value.addPageRequestListener((pageNo) {
      getListProduct(pageNo: pageNo);
    });
  }

  Future<void> onSearch(String value) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      state.textSearch.value = value;
      state.productPagingController.value.refresh();
    });
  }

  String formatDiscount(Proudct? item) {
    double discountValue = 0;
    if (item?.isPLU ?? false) {
      discountValue = (item?.discountValue ?? 0) / 10;
    } else {
      discountValue = (item?.discountValue ?? 0);
    }
    if (discountValue % 1 == 0) {
      return "${discountValue.toInt()}% OFF";
    } else if (discountValue % 1 == 0.5) {
      return "${discountValue.toStringAsFixed(1)}% OFF";
    } else {
      return "$discountValue% OFF";
    }
  }

  //region Product
  Future<void> getListProduct({
    required int pageNo,
    bool isRefresh = false,
  }) async {
    await xPagingDataHandler(
      pagingController: state.productPagingController.value,
      function: _productRepo.getAllProductPriceChecking(
        pageNo: pageNo,
        storeId: '10017',
        search: state.textSearch.value,
      ),
      isRefresh: isRefresh,
      pageNo: pageNo,
    );
  }

  //endregion
}
