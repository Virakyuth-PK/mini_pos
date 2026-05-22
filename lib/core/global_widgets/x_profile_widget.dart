import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/utils/app_ext.dart';
import 'x_button.dart';
import 'x_network_image.dart';

class XProfileAvatar extends StatelessWidget {
  const XProfileAvatar({
    super.key,
    required this.size,
    required this.imageUrls,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
  });

  final double size;
  final List<String> imageUrls;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: backgroundColor ?? Colors.white.withAlpha(10),
        child: XButton(onPress: onTap, child: _buildImageByPriority()),
      ),
    );
  }

  Widget _buildImageByPriority() {
    for (final url in imageUrls) {
      if (url.isNotEmpty) {
        return _buildNetworkImage(url);
      }
    }

    // Final fallback icon
    return Icon(
      Icons.account_circle,
      size: size,
      color: iconColor ?? Colors.grey,
    );
  }

  Widget _buildNetworkImage(String url) {
    final bool isChipmongImage = url.contains("portal.chipmong.com");

    return ClipOval(
      child: isChipmongImage
          ? OverflowBox(
              minWidth: size,
              minHeight: size,
              maxWidth: size,
              // maxHeight : make it taller so it can overflow downward
              maxHeight: size * 5,
              alignment: Alignment.topCenter,
              fit: OverflowBoxFit.deferToChild,
              child: Padding(
                padding: EdgeInsets.only(top: 5.d),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: XNetworkImage(
                    src: url,
                    width: size,
                    // important: same as maxHeight (or bigger)
                    height: size * 1.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          : FittedBox(
              fit: BoxFit.cover,
              child: XNetworkImage(
                src: url,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
