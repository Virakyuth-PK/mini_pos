import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../core/utils/x_paging_data_handler.dart';
import '../../data/repo/promotion_repo.dart';
import '../../model/proudct/proudct.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final ProductRepo _productRepo = Get.find<ProductRepo>();
  final PromotionRepo _promotionRepo = Get.find<PromotionRepo>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    state.categoryPagingController.value.addPageRequestListener((pageNo) {
      getCategoryList(pageNo: pageNo);
    });
    state.productPagingController.value.addPageRequestListener((pageNo) {
      getListProduct(pageNo: pageNo);
    });
    await getAppVersion();
    await getPromotionList();
  }

  Future<void> getPromotionList() async {
    var result = await _promotionRepo.getPromotionBanner();

    state.imageUrlList =
        result?.data
            ?.map((e) => e.bannerFile?.thumbnailFilePath ?? '')
            .whereType<String>()
            .toList() ??
        [];

    update();
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

  Future<void> getListProduct({
    required int pageNo,
    bool isRefresh = false,
  }) async {
    state.isLoading.value = true;
    await xPagingDataHandler(
      pagingController: state.productPagingController.value,
      function: _productRepo.getAllProductPriceChecking(
        pageNo: pageNo,
        storeId: '10017',
        // search: (searchTextEditingController?.text ?? ""),
      ),
      onComplete: (data) async {
        state.isLoading.value = false;
        update();
        return data;
      },
      isRefresh: isRefresh,
      pageNo: pageNo,
    );
  }

  Future<void> getCategoryList({
    required int pageNo,
    bool isRefresh = false,
  }) async {
    await xPagingDataHandler(
      pagingController: state.categoryPagingController.value,
      function: _productRepo.getCategory(
        pageNo: pageNo,
        storeId: '10017',
        // search: (searchTextEditingController?.text ?? ""),
      ),
      isRefresh: isRefresh,
      pageNo: pageNo,
    );
  }

  void onChangeCategory(int index) {
    state.currentIndex.value = index;
    state.productPagingController.value.refresh();
    update();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    state.appVersion.value = "v$version";
  }
}
