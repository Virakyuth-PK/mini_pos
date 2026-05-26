import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/global_widgets/x_button.dart';
import 'package:mini_pos/core/utils/app_color.dart';
import 'package:mini_pos/core/utils/app_style.dart';
import 'package:mini_pos/core/utils/text_size.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../core/services/gemini_service.dart';
import '../../../core/utils/app_ext.dart';
import 'state.dart';

class ProductDetailLogic extends GetxController {
  final ProductDetailState state = ProductDetailState();

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void onInit() {
    var arg = Get.arguments;

    if (arg != null) {
      state.productDetail = arg;
      update();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    // await ProductDetailAiClient().askAiAboutProduct(
    //   rawProductJson: state.productDetail!.toJson(),
    //   userQuestion: "How to use this product?",
    // );
  }

  Future<Uint8List> resizeForPrinter(Uint8List data, int targetWidth) async {
    final codec = await ui.instantiateImageCodec(data);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()..filterQuality = FilterQuality.high;

    // FORCE full width crop (NO aspect padding illusion)
    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final dst = Rect.fromLTWH(
      0,
      0,
      targetWidth.toDouble(),
      targetWidth * (image.height / image.width),
    );

    canvas.drawRect(dst, Paint()..color = const Color(0xFFFFFFFF));
    canvas.drawImageRect(image, src, dst, paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(targetWidth, dst.height.toInt());

    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  Future<void> captureAndPrint() async {
    try {
      Uint8List? image = await screenshotController.capture();

      if (image == null) return;

      final resized = await resizeForPrinter(image,570);

      final shouldPrint = await Get.dialog<bool>(
        Dialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.memory(
                    resized,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

              Positioned(
                bottom: 30,
                right: 15,
                left: 15,
                child: XButton(
                  onPress: () => Get.back(result: true),
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.d,
                      vertical: 15.d,
                    ),
                    decoration: xBoxDecoration(color: AppColor.primaryColor),
                    child: Center(
                      child: Text(
                        "Printer",
                        style: XTextStyle.medium(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      if (shouldPrint != true) return;

      // await SunmiPrinter.bindingPrinter();
      // await SunmiPrinter.initPrinter();

      await SunmiPrinter.printImage(resized,align: .CENTER);

      await SunmiPrinter.lineWrap(3);
      await SunmiPrinter.cutPaper();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
