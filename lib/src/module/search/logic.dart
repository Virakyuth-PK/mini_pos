import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';

import '../../../core/utils/x_paging_data_handler.dart';
import 'state.dart';

class SearchLogic extends GetxController {
  final ProductRepo _productRepo = Get.find();
  final SearchState state = SearchState();
  late StreamSubscription<bool> keyboardSubscription;
  TextEditingController? searchTextEditingController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.productPagingController.value.addPageRequestListener((pageNo) {
      getListProduct(pageNo: pageNo);
    });
    searchTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    // searchTextEditingController?.dispose();
    super.dispose();
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
        search: (searchTextEditingController?.text ?? ""),
      ),
      isRefresh: isRefresh,
      pageNo: pageNo,
    );
  }

  //endregion
}
