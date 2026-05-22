import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mini_pos/core/global_widgets/x_showmodal_bottom.dart';
import 'package:mini_pos/core/global_widgets/x_text_field.dart';
import 'package:mini_pos/core/utils/app_color.dart';
import 'package:mini_pos/core/utils/text_size.dart';
import 'package:mini_pos/route/app_route.dart';

import '../../../core/global_widgets/x_button.dart';
import '../../../core/global_widgets/x_network_image.dart';
import '../../../core/global_widgets/x_search_bar.dart';
import '../../../core/utils/app_ext.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/x_paged_child_builder_delegate.dart';
import '../../../translation/app_locale.dart';
import '../../model/proudct/proudct.dart';
import '../widget/product_item.dart';
import 'logic.dart';
import 'state.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final SearchLogic logic = Get.put(SearchLogic());
  final SearchState state = Get.find<SearchLogic>().state;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchLogic>(
      builder: (logic) {
        return Scaffold(
          key: scaffoldKey,
          appBar: _appBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _floatActionButton(),
          body: SizedBox(
            height: Get.height,
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        state.productPagingController.value.refresh(),
                    color: AppColor.primaryColor,
                    child: PagedGridView<int, Proudct>(
                      pagingController: state.productPagingController.value,
                      builderDelegate: XPagedChildBuilderDelegate.grid(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        newPageProgressIndicatorBuilder: (context) =>
                            Container().toShimmer,
                        isNeedShowFullScreenNoItemsFoundIndicatorBuilder: true,
                        itemBuilder: (context, item, index) {
                          return XButton(
                            onPress: () {
                              Get.toNamed(
                                AppRoute.productDetail,
                                arguments: item,
                              );
                              return;
                              xShowModalBottomSheet(
                                showBottomButton: true,
                                customBottomWidget: Container(
                                  margin: EdgeInsets.only(top: 15.d),
                                  child: XButton(
                                    onPress: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      width: Get.width,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 50.d,
                                        vertical: 15.d,
                                      ),
                                      decoration: xBoxDecoration(
                                        color: AppColor.primaryColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocale.back.tr,
                                          style: XTextStyle.large(
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                body:
                                    (
                                      BuildContext context,
                                      ScrollController scrollController,
                                    ) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 15.d,
                                        children: [
                                          XNetworkImage(
                                            height: 300.d,
                                            width: Get.width,
                                            fit: BoxFit.fitHeight,
                                            src:
                                                '${item.thumbnailImage?.thumbnailFilePath}',
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,

                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${item.nameKh}",
                                                      style: XTextStyle.medium(
                                                        fontSize: 20.d,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${item.nameEn}",
                                                      style: XTextStyle.medium(
                                                        fontSize: 20.d,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "${item.price.toCurrency()}",
                                                style: XTextStyle.medium(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25.d,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                              );
                            },
                            child: ProductItem(
                              product: item,
                              height: Get.width,
                              width: Get.height,
                              discount: logic.formatDiscount(item),
                            ),
                          );
                        },
                      ),
                      padding: EdgeInsets.all(10.0.d),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7.d,
                        mainAxisSpacing: 7.d,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar() => AppBar(
    backgroundColor: AppColor.primaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.d),
        bottomRight: Radius.circular(20.d),
      ),
    ),
    leadingWidth: 0.d,
    toolbarHeight: kToolbarHeight + 30.d,
    automaticallyImplyLeading: false,
    automaticallyImplyActions: false,
    title: Container(
      padding: EdgeInsetsGeometry.only(bottom: 15.d, top: 15.d),
      child: Row(
        spacing: 10.d,
        children: [
          Expanded(
            child: XTextField(
              contentPadding: EdgeInsets.zero,
              maxLines: 1,
              borderRadius: BorderRadius.circular(20.d),
              onChanged: (value) {
                logic.onSearch(value);
              },
              isDense: true,
              hintText: AppLocale.searchProduct.tr,

              prefixIcon: Icon(
                Icons.search,
                size: 20.0.d,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _floatActionButton() => Container(
    margin: EdgeInsetsGeometry.symmetric(horizontal: 15.d, vertical: 15.d),
    width: Get.width,
    height: 50.d,
    child: FloatingActionButton.extended(
      onPressed: () => Get.back(),
      backgroundColor: AppColor.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.d)),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_ios_new, color: AppColor.white),
          SizedBox(width: 8.d),
          Text("Back", style: TextStyle(color: AppColor.white)),
        ],
      ),
    ),
  );
}
