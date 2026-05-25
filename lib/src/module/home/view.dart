import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mini_pos/core/app/service/barcode_scanner_service.dart';
import 'package:mini_pos/core/global_widgets/design_by.dart';
import 'package:mini_pos/core/utils/app_color.dart';
import 'package:mini_pos/core/utils/app_style.dart';
import 'package:mini_pos/core/utils/text_size.dart';
import 'package:mini_pos/route/app_route.dart';
import 'package:mini_pos/src/module/widget/product_item.dart';

import '../../../core/global_widgets/x_button.dart';
import '../../../core/global_widgets/x_network_image.dart';
import '../../../core/global_widgets/x_showmodal_bottom.dart';
import '../../../core/utils/app_ext.dart';
import '../../../core/utils/empty_data.dart';
import '../../../core/utils/loading_shimmer.dart';
import '../../../core/utils/x_paged_child_builder_delegate.dart';
import '../../../gen/assets.gen.dart';
import '../../../translation/app_locale.dart';
import '../../model/category_response/category_response.dart';
import '../../model/proudct/proudct.dart';
import 'logic.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      floatingActionButton: _floatActionButton(),
      // bottomNavigationBar: _bottomNavigationBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: AlignmentGeometry.topCenter,
                image: AssetImage(Assets.icon.home.mainPagePg.path),
              ),
            ),
            padding: .symmetric(vertical: 40.d),
            child: GetBuilder<HomeLogic>(
              builder: (logic) {
                return Column(
                  children: [
                    Expanded(flex: 6, child: _buildPromotionSlider()),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: .symmetric(horizontal: 20.d),
                        child: Column(
                          spacing: 10.d,
                          children: [
                            _buildCategory(),
                            Expanded(flex: 3, child: _productGridView()),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _bottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _productGridView() {
    return GetBuilder<HomeLogic>(
      builder: (logic) {
        if (state.isLoading.value == true) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5.d),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => xSpaceH(size: 5.d),
              itemBuilder: (_, __) => Container(
                padding: EdgeInsets.all(6.0.d),
                width: 170.d,
                height: 100.d,
                color: Colors.red,
              ).toShimmer,
            ),
          );
        }
        return PagedListView<int, Proudct>.separated(
          separatorBuilder: (context, index) {
            return xSpaceH(size: 5.0.d);
          },
          scrollDirection: Axis.horizontal,
          pagingController: state.productPagingController.value,
          padding: EdgeInsets.zero,
          builderDelegate: XPagedChildBuilderDelegate.list(
            newPageProgressIndicatorBuilder: (context) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.d),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, __) => xSpaceH(size: 5.d),
                  itemBuilder: (_, __) => Container(
                    padding: EdgeInsets.all(6.0.d),
                    width: 170.d,
                    height: 100.d,
                    color: Colors.red,
                  ).toShimmer,
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (context) => EmptyData(),
            firstPageErrorIndicatorBuilder: (context) => EmptyData(),
            itemBuilder: (context, item, index) {
              return XButton(
                onPress: () {
                  Get.toNamed(AppRoute.productDetail, arguments: item);
                },
                child: ProductItem(
                  product: item,
                  height: Get.height,
                  discount: logic.formatDiscount(item),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategory() {
    return SizedBox(
      height: 140.0.d,
      width: Get.width,
      child: PagedListView<int, CategoryResponse>.separated(
        padding: EdgeInsets.only(
          right: 15..d,
          top: 15..d,
          bottom: 10..d,
          left: 15.0.d,
        ),
        separatorBuilder: (context, index) => xSpaceH(size: 15.d),
        pagingController: state.categoryPagingController.value,
        scrollDirection: Axis.horizontal,
        builderDelegate: XPagedChildBuilderDelegate.list(
          scrollDirection: Axis.horizontal,
          firstPageProgressIndicatorBuilder: (context) => LoadingShimmer.list(
            width: 150..d,
            scrollDirection: Axis.horizontal,
          ),
          itemBuilder: (context, item, index) {
            var isActive = state.currentIndex.value == index;
            return XButton(
              onPress: () {
                if (state.currentIndex.value == index) return;
                logic.onChangeCategory(index);
              },
              child: Container(
                height: 130.0.d,
                width: 100..d,
                decoration: xBoxDecoration(
                  hasBorder: true,
                  borderWidth: 1.5.d,
                  borderColor: isActive ? AppColor.primaryColor : Colors.white,
                  // color: isActive
                  //     ? AppColor.primaryColor.withValues(alpha: 0.02)
                  //     : Colors.white,
                  boxShadow: [
                    isActive == true
                        ? BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.08),
                            blurRadius: 28.d,
                            offset: const Offset(0, 2),
                          )
                        : BoxShadow(
                            color: AppColor.hintColor.withOpacity(0.08),
                            blurRadius: 28.d,
                            offset: const Offset(0, 2),
                          ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10..d),
                        child: XNetworkImage(
                          src: item.image ?? "",
                          fit: BoxFit.contain,
                          isNeedErrorDesc: false,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 5.d),
                        child: Text(
                          "${item?.nameEn}".toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: XTextStyle.regular(
                            fontSize: 11.0.d,
                            color: isActive
                                ? AppColor.primaryColor
                                : Color(0xff56575A),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPromotionSlider() {
    if (state.imageUrlList.isEmpty) {
      return SizedBox.shrink();
    }
    return SizedBox(
      height: double.infinity,
      width: Get.width,
      child: CarouselSlider.builder(
        itemCount: state.imageUrlList.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: XNetworkImage(
                  height: double.infinity,
                  src: state.imageUrlList[itemIndex] ?? "",
                  fit: .fitHeight,
                ),
              ),
              Positioned(
                bottom: 10.d,
                right: 10.d,
                child: Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 10.d,
                    vertical: 5.d,
                  ),
                  decoration: xBoxDecoration(
                    color: AppColor.primaryColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${state.currentIndexSlide.value + 1} / ${state.imageUrlList.length}",
                    style: XTextStyle.regular(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.d,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            state.currentIndexSlide.value = index;
            logic.update();
          },
          height: double.infinity,
          aspectRatio: 0.2,
          viewportFraction: 0.9,
          initialPage: 0,
          enlargeFactor: 0.2,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
      ),
    );
  }

  FloatingActionButton _floatActionButton() => FloatingActionButton(
    onPressed: () {
      Get.toNamed(AppRoute.search);
      // Get.find<BarcodeScannerService>().searchProduct('010700519528');
    },
    backgroundColor: AppColor.primaryColor,
    shape: const CircleBorder(),
    child: Padding(
      padding: .all(15.d),
      child: SvgPicture.asset(Assets.svg.scan, width: 50.d),
    ),
  );

  Widget _bottomNavigationBar() {
    return Container(
      height: 40.d,
      decoration: xBoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: .symmetric(vertical: 5.d),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 10.d,
          children: [
            SvgPicture.asset(Assets.svg.cmtrLogo, fit: .fitHeight),
            VerticalDivider(),
            SvgPicture.asset(Assets.svg.cmgsvg, fit: .fitHeight),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text("Develop By", style: XTextStyle.bold(fontSize: 8.d)),
                Row(
                  spacing: 5.d,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "CHIP MONG",
                      style: XTextStyle.bold(fontSize: 8.d, fontWeight: .w900),
                    ),
                    Text(
                      "GROUP",
                      style: XTextStyle.bold(
                        fontSize: 8.d,
                        fontWeight: .w900,
                        color: CompanyColor.CHIPMONG_GROUP,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
