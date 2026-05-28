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
  // final aiChatKey = GlobalKey<ProductAiChatSectionState>();
  void Function(String value)? sendAiMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomNavWidget(
        enableAIMode: true,
        onSubmit: (String value) async =>
             sendAiMessage?.call(value),
      ),
      body: GetBuilder<ProductDetailLogic>(
        builder: (logic) {
          return Column(
            spacing: 10,
            children: [
              Expanded(
                flex: 6,
                child: ProductInfoSection(
                  productImage:
                      state.productDetail?.thumbnailImage?.filePath ?? "",
                  productNameKh: state.productDetail?.nameEn ?? "",
                  productName: state.productDetail?.nameKh ?? "",
                  price: state.productDetail?.price ?? 0,
                  stockStatus: "Available",
                ),
              ),
              Expanded(
                flex: 5,
                child: ProductAiChatSection(
                  key: ValueKey(state.productDetail?.barcode),
                  productName: state.productDetail?.nameKh ?? "",
                  productInfo: state.productInfo,
                  onReady: (send) {
                    sendAiMessage = send;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
