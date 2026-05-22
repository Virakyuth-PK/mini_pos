import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mini_pos/core/global_widgets/design_by.dart';
import 'package:mini_pos/core/utils/app_color.dart';
import 'package:mini_pos/core/utils/app_style.dart';
import 'package:mini_pos/core/utils/text_size.dart';
import 'package:mini_pos/route/app_route.dart';

import '../../../core/global_widgets/x_button.dart';
import '../../../core/global_widgets/x_network_image.dart';
import '../../../core/global_widgets/x_showmodal_bottom.dart';
import '../../../core/utils/app_ext.dart';
import '../../../core/utils/loading_shimmer.dart';
import '../../../core/utils/x_paged_child_builder_delegate.dart';
import '../../../gen/assets.gen.dart';
import '../../../translation/app_locale.dart';
import '../../model/category_response/category_response.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Padding(
          padding: EdgeInsets.all(15.d),
          child: SvgPicture.asset(Assets.svg.scan, width: 50.d),
        ),
        onPressed: () {
          print("Tapped small FAB");
        },
        backgroundColor: AppColor.primaryColor,
        shape: const CircleBorder(),
      ),
      body: Stack(
        children: [
          Image.asset(Assets.icon.home.mainPagePg.path, width: Get.width),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.d),
              child: GetBuilder<HomeLogic>(
                builder: (logic) {
                  return Column(
                    spacing: 15.d,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      xSpaceV(),
                      _buildPromotionSlider(),
                      _buildCategory(),
                      Expanded(child: _productGridView()),
                      Align(alignment: Alignment.center, child: DesignBy()),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productGridView() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.d,
        crossAxisSpacing: 15.d,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return XButton(
          onPress: () {
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
                    decoration: xBoxDecoration(color: AppColor.primaryColor),
                    child: Center(
                      child: Text(
                        AppLocale.back.tr,
                        style: XTextStyle.large(color: AppColor.white),
                      ),
                    ),
                  ),
                ),
              ),
              body: (BuildContext context, ScrollController scrollController) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15.d,
                    children: [
                      XNetworkImage(
                        height: 300.d,
                        width: Get.width,
                        fit: BoxFit.fitHeight,
                        src:
                            'https://storage.googleapis.com/dev_bucket_cmrt/cmrt-supermarket-media/Item/028400003575/028400003575_1_thumbnail.png?t=1779338414',
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NR-SDACH NEAK MEAS',
                                  style: XTextStyle.medium(fontSize: 20.d),
                                ),
                                Text(
                                  'ស្ដេចនាគមាស',
                                  style: XTextStyle.medium(fontSize: 20.d),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${double.parse('12.2').toCurrency()}/ KG",
                            style: XTextStyle.medium(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: xBoxDecoration(hasShadow: true),
            child: Padding(
              padding: EdgeInsets.all(8.0.d),
              child: Column(
                spacing: 5.d,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: XNetworkImage(
                        width: Get.width,
                        height: 100.d,
                        fit: BoxFit.fitHeight,
                        src:
                            'https://storage.googleapis.com/dev_bucket_cmrt/cmrt-supermarket-media/Item/028400003575/028400003575_1_thumbnail.png?t=1779338414',
                      ),
                    ),
                  ),
                  Text(
                    'NR-SDACH NEAK MEAS',
                    style: XTextStyle.regular(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'ស្ដេចនាគមាស',
                    style: XTextStyle.regular(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${double.parse('12.2').toCurrency()}/ KG",
                    style: XTextStyle.medium(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategory() {
    return SizedBox(
      height: 165.0.d,
      width: Get.width,
      child: PagedListView<int, CategoryResponse>.separated(
        padding: EdgeInsets.only(
          right: 15..d,
          top: 15..d,
          bottom: 10..d,
          left: 1.0.d,
        ),
        separatorBuilder: (context, index) => xSpaceH(),
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
            return Container(
              height: 180.0.d,
              width: 120..d,
              decoration: xBoxDecoration(color: Colors.white, hasShadow: true),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${item?.nameEn}".toUpperCase(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: XTextStyle.regular(
                          fontSize: 11.0.d,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    return Row(
      spacing: 15.d,
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) {
                var isActive = state.currentIndex.value == index;
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.d,
                    vertical: 15.d,
                  ),
                  child: XButton(
                    onPress: () {
                      logic.onChangeCategory(index);
                    },
                    child: Container(
                      width: 110.d,
                      padding: EdgeInsets.symmetric(horizontal: 5.d),
                      decoration: xBoxDecoration(
                        borderRadius: BorderRadius.circular(20.d),
                        boxShadow: [
                          BoxShadow(
                            color: isActive
                                ? AppColor.primaryColor.withValues(alpha: 0.4)
                                : Colors.black.withValues(alpha: 0.1),
                            offset: Offset(0, 2),
                            blurRadius: 4.d,
                          ),
                        ],
                        color: isActive
                            ? AppColor.primaryColor
                            : AppColor.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 130.d,
                            child: XNetworkImage(
                              fit: BoxFit.cover,
                              src:
                                  'https://storage.googleapis.com/dev_bucket_cmrt/cmrt-supermarket-media/MainCategory/33/33_1.jpg?t=1779333752',
                            ),
                          ),
                          Text(
                            "BEER WINE WINE",
                            style: XTextStyle.medium(
                              fontWeight: FontWeight.bold,
                              fontSize: XFontSize.xS12,
                              color: isActive
                                  ? AppColor.white
                                  : AppColor.hintColor,
                            ),

                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        XButton(
          onPress: () {
            Get.toNamed(AppRoute.search);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.d, horizontal: 15.d),
            decoration: xBoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor.withValues(alpha: 0.2),
            ),
            child: Icon(Icons.search, color: AppColor.primaryColor, size: 35.d),
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionSlider() {
    Widget? content;
    if ((state.imageUrlList ?? []).isNotEmpty) {
      content = Stack(
        children: [
          CarouselSlider.builder(
            itemCount: state.imageUrlList.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: Get.height,
                      child: XNetworkImage(
                        height: Get.height,
                        src: state.imageUrlList[itemIndex] ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
            options: CarouselOptions(
              height: Get.height * 0.5,
              onPageChanged: (index, reason) {
                state.currentIndexSlide.value = index;
                logic.update();
              },
              aspectRatio: 0.1,
              viewportFraction: 0.85,
              initialPage: 0,
              enlargeFactor: 0.2,
              autoPlay: true,
              enlargeCenterPage: false,
            ),
          ),

          Positioned(
            bottom: 15.d,
            right: 15.d,
            child: Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 10.d, vertical: 5.d),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(20.d),
                ),
                child: Text(
                  "${state.currentIndexSlide.value + 1}/${state.imageUrlList.length}",
                  style: XTextStyle.medium(
                    fontWeight: FontWeight.bold,
                    fontSize: XFontSize.xS12,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      content = const SizedBox.shrink();
    }
    return content;
  }
}
