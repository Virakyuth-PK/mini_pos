import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../core/services/gemini_service.dart';
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

  Future<void> captureAndPrint() async {
    try {
      Uint8List? image = await screenshotController.capture();

      if (image == null) return;

      await SunmiPrinter.bindingPrinter();
      await SunmiPrinter.initPrinter();

      await SunmiPrinter.printImage(image, align: SunmiPrintAlign.CENTER);

      await SunmiPrinter.lineWrap(3);

      // Cut paper
      await SunmiPrinter.cut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
