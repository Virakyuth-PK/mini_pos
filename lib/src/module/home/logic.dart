import 'package:get/get.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';

import '../../../core/utils/x_paging_data_handler.dart';
import '../../data/repo/promotion_repo.dart';
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

  Future<void> getListProduct({
    required int pageNo,
    bool isRefresh = false,
  }) async {
    await xPagingDataHandler(
      pagingController: state.productPagingController.value,
      function: _productRepo.getAllProductPriceChecking(
        pageNo: pageNo,
        storeId: '10017',
        // search: (searchTextEditingController?.text ?? ""),
      ),
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
    update();
  }
}
