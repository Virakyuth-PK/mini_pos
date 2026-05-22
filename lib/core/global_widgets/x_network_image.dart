import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/global_widgets/x_open_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../gen/assets.gen.dart';
import '../config/local/x_network_image_cache_manager.dart';
import '../utils/app_ext.dart';
import '../utils/app_style.dart';
import 'x_button.dart';

class XNetworkImage extends StatefulWidget {
  final String src;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final String loadingDescription;
  final String? errorDescription;
  final double? errorIconSize;
  final double? errorFontSize;
  final bool isNeedErrorDesc;
  final bool isNeedErrorPadding;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  final double? initChildSize;
  final Function(bool hasError)? onError;
  final bool showImageDetail;

  const XNetworkImage({
    super.key,
    this.onError,
    required this.src,
    this.fit,
    this.errorWidget,
    this.height,
    this.width,
    this.loadingDescription = "",
    this.errorDescription,
    this.errorIconSize,
    this.errorFontSize,
    this.borderRadius,
    this.isNeedErrorDesc = true,
    this.isNeedErrorPadding = true,
    this.initChildSize,
    this.showImageDetail = true,
  });

  @override
  State<XNetworkImage> createState() => _XNetworkImageState();
}

class _XNetworkImageState extends State<XNetworkImage> {
  bool _isImageLoaded = false;
  bool _hasError = false;
  ImageStream? _imageStream;
  ImageStreamListener? _imageListener;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(XNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src) {
      _loadImage();
    }
  }

  void _loadImage() {
    final imageProvider = CachedNetworkImageProvider(
      widget.src,
      cacheKey: removeQueryParameters(widget.src),
      cacheManager: XNetworkImageCacheManager.instance,
    );

    _imageStream?.removeListener(_imageListener!);
    final stream = imageProvider.resolve(ImageConfiguration.empty);
    _imageStream = stream;
    _imageListener = ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        if (mounted) {
          setState(() {
            _isImageLoaded = true;
          });
        }
      },
      onError: (exception, stackTrace) {
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
      },
    );
    stream.addListener(_imageListener!);
  }

  @override
  void dispose() {
    _imageStream?.removeListener(_imageListener!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return XButton(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0.d),
      onPress: widget.showImageDetail == true
          ? () async {
              if (_isImageLoaded && !_hasError) {
                await xOpenImageView(
                  url: widget.src,
                  // initChildSize: widget.initChildSize,
                );
              } else {
                if (await canLaunchUrl(Uri.parse(widget.src))) {
                  await launchUrl(
                    Uri.parse(widget.src),
                    mode: LaunchMode.externalApplication,
                  );
                }
              }
            }
          : null,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0.d),
          child: CachedNetworkImage(
            imageUrl: widget.src,
            fit: widget.fit ?? BoxFit.fitWidth,
            // memCacheHeight: widget.height?.toInt(),
            // memCacheWidth: widget.width?.toInt(),
            cacheKey: removeQueryParameters(widget.src),
            filterQuality: FilterQuality.high,
            cacheManager: XNetworkImageCacheManager.instance,
            errorWidget: (context, url, error) {
              if (widget.onError != null) {
                widget.onError!(true);
              }
              return Padding(
                padding: widget.isNeedErrorPadding
                    ? EdgeInsets.all(10.0.d)
                    : EdgeInsets.zero,
                child:
                    widget.errorWidget ??
                    SvgPicture.asset(
                      Assets.svg.noImage,
                      height: widget.errorIconSize,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
              );
            },
            progressIndicatorBuilder: (context, url, progress) {
              double? progressValue = progress.progress;
              return Stack(
                children: [
                  Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: xBoxDecoration(color: Colors.red),
                  ).toShimmer,
                  if (progressValue != null)
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.all(10.0.d),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: LinearProgressIndicator(
                            value: progressValue,
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0.d),
                            backgroundColor: Colors.grey.withValues(alpha: 0.3),
                            minHeight: 4.0.d,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
