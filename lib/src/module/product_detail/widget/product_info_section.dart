
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/utils/text_size.dart';

import '../../../../core/global_widgets/x_button.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_style.dart';
import '../logic.dart';
import '../state.dart';

class ProductInfoSection extends StatelessWidget {
  final String productNameKh;
  final String productName;
  final double price;
  final String? origin;
  final String? stockStatus;

  ProductInfoSection({
    super.key,

    required this.productNameKh,
    required this.productName,
    required this.price,
    this.origin,
    this.stockStatus,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 20),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _originBadge(),
          _title(),
          _priceRow(),
          Divider(thickness: .3,color: AppColor.primaryColor.withValues(alpha: .5),),
          _description(),
        ],
      ),
    );
  }

  Widget _originBadge() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
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
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          "\$${price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        XButton(
          onPress: () => Get.find<ProductDetailLogic>().captureAndPrint(),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: xBoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.print, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _description() {
    return  AutoSizeText(
      "Premium polyethylene cling wrap optimized for food safety packaging applications. Keeps meals fresh longer.",
      style: XTextStyle.regular(fontSize: 5),
    );
  }
}