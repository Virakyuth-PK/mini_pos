import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/global_widgets/x_loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../translation/app_locale.dart';
import '../app/state.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/app_style.dart';
import '../utils/text_size.dart';
import 'x_button.dart';
import 'x_showmodal_bottom.dart';

Future<void> xOpenImageView({
  String? url, // use
  String? filePath, //use
  String? fileAsset, // use
  Uint8List? byteImage,
  List<String>? urlList, //use
  List<String>? filePathList,
  List<Uint8List>? byteImageList,
  bool isHaveAction = false, //use
  bool isShowList = false, //use
  bool isCircle = false, //use
  bool? boxFitContain,
  Function()? actionPress, //use
  String? actionText, //use
  String? title, //use
  Function()? onRemove,
}) {
  return xShowModalBottomSheet(
    initialChildSize: 0.8,
    maxChildSize: 1,
    backgroundColor: Colors.white,
    showBottomButton: isHaveAction,
    customBottomWidget: isHaveAction
        ? XButton(
            onPress: actionPress,
            toolTip: actionText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: xBoxDecoration(color: primaryColor),
                  width: Get.width * 0.9,
                  padding: EdgeInsets.all(10.0.d),
                  child: Center(
                    child: Text(
                      actionText ?? "",
                      style: XTextStyle.regular(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        : null,
    body: (context, scrollController) => SizedBox(
      height: Get.height * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0.d),
          topLeft: Radius.circular(20.0.d),
        ),
        child: ImageViewWidget(
          byteImage: byteImage,
          filePath: filePath,
          isHaveAction: isHaveAction,
          url: url,
          actionPress: actionPress,
          actionText: actionText,
          byteImageList: byteImageList,
          filePathList: filePathList,
          urlList: urlList,
          isShowList: isShowList,
          title: title,
          fileAsset: fileAsset,
          isCircle: isCircle,
          boxFitContain: boxFitContain,
          onRemove: onRemove,
        ),
      ),
    ),
  );
}

class ImageViewWidget extends StatefulWidget {
  final Uint8List? byteImage;
  final String? filePath, fileAsset, url, actionText, title;
  final bool? isHaveAction, isCircle, isShowList;
  final Function()? actionPress;
  final List<String>? urlList;
  final List<String>? filePathList;
  final List<Uint8List>? byteImageList;
  final Function()? onRemove;
  bool? boxFitContain;

  ImageViewWidget({
    super.key,
    this.byteImage,
    this.filePath,
    this.url,
    this.isHaveAction,
    this.isShowList,
    this.actionPress,
    this.actionText,
    this.urlList,
    this.filePathList,
    this.byteImageList,
    this.title,
    this.fileAsset,
    this.isCircle,
    this.onRemove,
    this.boxFitContain,
  });

  @override
  State<ImageViewWidget> createState() => _ImageViewWidgetState();
}

class _ImageViewWidgetState extends State<ImageViewWidget> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isShowList == false) {
      // Single image display logic remains unchanged
      ImageProvider imageProvider;
      if (widget.byteImage != null) {
        imageProvider = MemoryImage(widget.byteImage!);
      } else if (widget.filePath != null) {
        imageProvider = FileImage(File(widget.filePath!));
      } else if (widget.fileAsset != null) {
        imageProvider = AssetImage(widget.fileAsset!);
      } else {
        imageProvider = NetworkImage(widget.url ?? "");
      }
      return Dismissible(
        direction: DismissDirection.none,
        key: UniqueKey(),
        onDismissed: (_) => Get.back(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Builder(
              builder: (context) {
                final isCircle = widget.isCircle ?? false;
                final content = PhotoViewGestureDetectorScope(
                  axis: Axis.horizontal,
                  child: PhotoView(
                    disableGestures: false,
                    enablePanAlways: true,
                    enableRotation: false,
                    strictScale: false,
                    tightMode: true,
                    imageProvider: imageProvider,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    loadingBuilder: (context, event) =>
                        Center(child: xLoading()),
                    initialScale: widget.boxFitContain == true
                        ? PhotoViewComputedScale.contained
                        : isCircle
                        ? PhotoViewComputedScale.covered
                        : null,
                    filterQuality: FilterQuality.high,
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 10,
                  ),
                );

                final clippedContent = ClipRRect(
                  borderRadius: BorderRadius.circular(
                    isCircle ? 500.0.d : 10.0.d,
                  ),
                  child: content,
                );

                return Padding(
                  padding: EdgeInsets.all(10.0.d),
                  child: isCircle
                      ? AspectRatio(aspectRatio: 1, child: clippedContent)
                      : clippedContent,
                );
              },
            ),

            Positioned(
              top: 30.0.d,
              left: 20.0.d,
              child: SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  widget.title ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: primaryColor),
                ),
              ),
            ),

            widget.onRemove != null
                ? Positioned(
                    top: 5.d,
                    right: 10.d,
                    child: XButton(
                      onPress: widget.onRemove,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          spacing: 8.d,
                          children: [
                            Icon(CupertinoIcons.trash_circle_fill),
                            Text(AppLocale.remove.tr),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      );
    } else {
      // Display a list of images using PageView
      List<Widget> imagePages = [];

      if (widget.byteImageList != null) {
        imagePages = widget.byteImageList!
            .map((image) => _buildPageViewImage(MemoryImage(image)))
            .toList();
      } else if (widget.filePathList != null) {
        imagePages = widget.filePathList!
            .map((filePath) => _buildPageViewImage(FileImage(File(filePath))))
            .toList();
      } else if (widget.urlList != null) {
        imagePages = widget.urlList!
            .map((url) => _buildPageViewImage(NetworkImage(url)))
            .toList();
      }

      return Dismissible(
        direction: DismissDirection.none,
        key: UniqueKey(),
        onDismissed: (_) => Get.back(),
        child: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0.d),
                child: PageView(
                  controller: _pageController,
                  children: imagePages,
                ),
              ),
              Positioned(
                top: 20.0.d,
                right: 10.0.d,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: primaryColor,
                    size: 30.0.d,
                    shadows: const [
                      BoxShadow(color: Colors.black, spreadRadius: 2),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //     top: 30.0.d,
              //     left: 20.0.d,
              //     child: Text(AppLocale.image.tr,
              //         style: Theme.of(context)
              //             .textTheme
              //             .headlineMedium
              //             ?.copyWith(
              //                 color: primaryColor(context)))),
              Positioned(
                bottom: 50.0.d,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: imagePages.length,
                  effect: ScrollingDotsEffect(
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    activeDotColor: primaryColor,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildPageViewImage(ImageProvider imageProvider) {
    return Padding(
      padding: EdgeInsets.all(10.0.d),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0.d),
        child: PhotoViewGestureDetectorScope(
          axis: Axis.horizontal,
          child: PhotoView(
            disableGestures: false,
            enablePanAlways: true,
            enableRotation: false,
            strictScale: false,
            tightMode: true,
            imageProvider: imageProvider,
            backgroundDecoration: const BoxDecoration(color: Colors.white),
            loadingBuilder: (context, event) => Center(child: xLoading()),
            minScale: PhotoViewComputedScale.contained * 0.5,
            maxScale: PhotoViewComputedScale.covered * 10,
          ),
        ),
      ),
    );
  }
}
