import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/global_widgets/x_network_image.dart';
import 'package:mini_pos/src/module/product_detail/state.dart';
import 'package:mini_pos/src/module/product_detail/widget/product_ai_chat_section.dart';
import 'package:mini_pos/src/module/product_detail/widget/product_info_section.dart';
import 'package:screenshot/screenshot.dart';
import '../../../core/utils/app_log.dart';
import '../widget/bottom_nav_widget.dart';
import 'logic.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  final ProductDetailLogic logic = Get.put(ProductDetailLogic());
  final ProductDetailState state = Get.find<ProductDetailLogic>().state;
  final aiChatKey = GlobalKey<ProductAiChatSectionState>();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: logic.screenshotController,
      child: Scaffold(
        bottomSheet: BottomNavWidget(
          enableAIMode: true,
          onSubmit: (String value) async =>
              await aiChatKey.currentState?.sendMessage(value),
        ),
        body: Column(
          spacing: 10,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 2,
                    child: XNetworkImage(
                      src: state.productDetail?.thumbnailImage?.filePath ?? "",
                      fit: BoxFit.fitWidth,
                      errorWidget: SizedBox.shrink(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ProductInfoSection(
                      productNameKh: state.productDetail?.nameEn ?? "",
                      productName: state.productDetail?.nameKh ?? "",
                      price: state.productDetail?.price ?? 0,
                      stockStatus: "Available",
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: ProductAiChatSection(
                key: aiChatKey,
                productName: state.productDetail?.nameKh ?? "",
                productInfo: state.productInfo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
