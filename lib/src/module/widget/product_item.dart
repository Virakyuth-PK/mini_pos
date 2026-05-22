import 'package:flutter/material.dart';

import '../../../core/global_widgets/x_button.dart';
import '../../../core/global_widgets/x_network_image.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_ext.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/text_size.dart';
import '../../model/proudct/proudct.dart';

class ProductItem extends StatelessWidget {
  final Proudct? product;
  final double? height;
  final double? width;
  final String? discount;

  const ProductItem({
    super.key,
    this.product,
    this.height,
    this.width,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(6.0.d),
          child: Container(
            height: height ?? 200.0.d,
            width: width ?? 170.0.d,
            decoration: xBoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.hintColor.withOpacity(0.08),
                  blurRadius: 28.d,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: XButton(
              onPress: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: XNetworkImage(
                        src: product?.thumbnailImage?.thumbnailFilePath ?? "",
                        fit: BoxFit.fill,
                        isNeedErrorDesc: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.0.d,
                      right: 10.0.d,
                      bottom: 10.0.d,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product?.nameEn ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: XTextStyle.regular(
                            fontSize: 10.0.d,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        xSpaceV(size: 5.0.d),
                        Row(
                          children: [
                            Text(
                              (product?.price ?? 0.0).toCurrency(),
                              style: XTextStyle.regular(
                                fontSize: 14.d,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            xSpaceH(size: 5..d),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (product?.discountTypeId == 1 &&
            ((product?.price ?? 0) != (product?.offerPrice ?? 0)))
          Positioned(
            top: 5.0.d,
            left: 5.0.d,
            child: Container(
              decoration: xBoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0.d),
                  bottomRight: Radius.circular(10.0.d),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5.0.d, vertical: 2.0.d),
              child: Text(
                "${discount}",
                style: XTextStyle.medium(color: Colors.white, fontSize: 10.0.d),
              ),
            ),
          ),
      ],
    );
  }
}
