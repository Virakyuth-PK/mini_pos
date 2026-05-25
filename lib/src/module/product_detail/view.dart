import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/global_widgets/x_button.dart';
import 'package:mini_pos/core/global_widgets/x_network_image.dart';
import 'package:mini_pos/core/utils/app_color.dart';
import 'package:mini_pos/route/app_route.dart';
import 'package:mini_pos/src/module/product_detail/state.dart';
import '../../../core/app/service/barcode_scanner_service.dart';
import '../../../core/utils/app_ext.dart';
import 'logic.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // final ProductDetailLogic logic = Get.find<ProductDetailLogic>();
  //
  final ProductDetailLogic logic = Get.put(ProductDetailLogic(), tag: '1');

  final ProductDetailState state = Get.find<ProductDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatActionButton(),
      body: GetBuilder<ProductDetailLogic>(
        tag: "1",
        builder: (logic) {
          return CustomProductDetailView(
            imageUrl:
                logic.state.productDetail?.thumbnailImage?.thumbnailFilePath ??
                "",
            productNameKh: logic.state.productDetail?.nameKh ?? "",
            productName: logic.state.productDetail?.nameEn ?? "",
            price: logic.state.productDetail?.price ?? 0.0,
          );
        },
      ),
    );
  }

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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      automaticallyImplyActions: false,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }
}

class CustomProductDetailView extends StatelessWidget {
  final String imageUrl;
  final String productNameKh;
  final String productName;
  final double price;

  const CustomProductDetailView({
    super.key,
    required this.imageUrl,
    required this.productNameKh,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250,
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          automaticallyImplyActions: false,
          surfaceTintColor: primaryColor,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final top = constraints.biggest.height;
              final isCollapsed = top <= kToolbarHeight + 20;
              return Container(
                color: isCollapsed ? Colors.white : Colors.transparent,
                child: FlexibleSpaceBar(
                  background: Center(
                    child: XNetworkImage(src: imageUrl, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          //   onPressed: () => Get.back(),
          // ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XButton(
                onPress: () async {
                  await Get.find<BarcodeScannerService>().searchProduct(
                    '0008600423830',
                  );
                  Get.toNamed(
                    AppRoute.productDetail,
                    arguments:
                        Get.find<ProductDetailLogic>().state.productDetail,
                  );
                },
                child: ProductInfoSection(
                  productNameKh: productNameKh,
                  productName: productName,
                  price: price,

                  stockStatus: "Available",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductImageHeader extends StatelessWidget {
  final String imageUrl;

  const ProductImageHeader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return XNetworkImage(src: imageUrl);
  }
}

class ProductInfoSection extends StatelessWidget {
  final String productNameKh;
  final String productName;
  final double price;
  final String? origin;
  final String? stockStatus;

  const ProductInfoSection({
    super.key,

    required this.productNameKh,
    required this.productName,
    required this.price,
    this.origin,
    this.stockStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _originBadge(),
            const SizedBox(height: 12),
            _title(),
            const SizedBox(height: 10),
            _priceRow(),
            const SizedBox(height: 16),
            const Divider(thickness: .3),
            const SizedBox(height: 12),
            _description(),
          ],
        ),
      ),
    );
  }

  Widget _originBadge() {
    return Wrap(
      spacing: 8,
      children: [
        if (productNameKh.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              productNameKh,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),

        if (stockStatus != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: stockStatus == "Available"
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              stockStatus!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: stockStatus == "Available" ? Colors.green : Colors.red,
              ),
            ),
          ),

        if (origin != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              origin!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }

  Widget _title() {
    return Text(
      productName,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
    );
  }

  Widget _priceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        Row(children: []),

        // const Row(
        //   children: [
        //     Icon(Icons.star, color: Colors.amber, size: 18),
        //     SizedBox(width: 4),
        //     Text("4.8 (1,200)", style: TextStyle(color: Colors.grey)),
        //   ],
        // ),
      ],
    );
  }

  Widget _description() {
    return SizedBox(
      height: 800,
      child: const Text(
        "Premium polyethylene cling wrap optimized for food safety packaging applications. Keeps meals fresh longer.",
        style: TextStyle(height: 1.4, color: Colors.black54),
      ),
    );
  }
}
