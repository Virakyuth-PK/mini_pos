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
import 'package:mini_pos/flavors.dart';
import 'package:mini_pos/route/app_route.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
      floatingActionButton: _floatActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: AlignmentGeometry.topCenter,
            image: AssetImage(Assets.icon.home.mainPagePg.path),
          ),
        ),
        padding: .symmetric(vertical: 40.d),
        child: Column(
          children: [
            Expanded(flex: 5, child: _buildPromotionSlider()),
            Expanded(
              flex: 4,
              child: Padding(
                padding: .symmetric(horizontal: 20.d),
                child: Column(
                  spacing: 10.d,
                  children: [
                    Expanded(flex: 1, child: _buildCategory()),
                    Expanded(flex: 2, child: _productGridView()),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      // height: 165.0.d,
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
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: XNetworkImage(
              height: double.infinity,
              src: state.imageUrlList[itemIndex] ?? "",
              fit: .fitHeight,
            ),
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
    onPressed: () => Get.toNamed(AppRoute.search),
    backgroundColor: AppColor.primaryColor,
    shape: const CircleBorder(),
    child: Padding(
      padding: .all(15.d),
      child: SvgPicture.asset(Assets.svg.scan, width: 50.d),
    ),
  );

  Widget _bottomNavigationBar() {
    return BottomAppBar(
      height: 50.d,
      child: Padding(
        padding: .symmetric(vertical: 2.d),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 10.d,
          children: [
            SvgPicture.asset(Assets.svg.cmtrLogo, fit: .fitHeight),
            VerticalDivider(),
            SvgPicture.asset(Assets.svg.cmgsvg, fit: .fitHeight),
            Column(
              spacing: 4.d,
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
            Align(
              alignment: .bottomLeft,
              child: Padding(
                padding: .only(bottom: 2.d),
                child: FutureBuilder<String>(
                  future: _getVersion(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    }

                    return Text(
                      snapshot.data ?? '',
                      style: XTextStyle.regular(
                        fontSize: 7.d,
                        color:  Colors.grey,
                      ),
                    );
                  },
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();

    // Release mode
    if (FConfig.appFlavor == Flavor.prd) {
      return 'v${info.version}';
    }

    // Dev / Debug mode
    return 'v${info.version} (${info.buildNumber})';
  }
}
