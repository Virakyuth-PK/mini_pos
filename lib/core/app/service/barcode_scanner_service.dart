import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/utils/app_ext.dart';
import 'package:mini_pos/src/data/repo/product_repo.dart';
import 'package:mini_pos/src/model/proudct/image_response.dart';

import '../../../route/app_route.dart';
import '../../../src/model/proudct/proudct.dart';
import '../../../src/module/product_detail/logic.dart';

import '../../../route/app_route.dart';

class BarcodeScannerService extends GetxService {
  final StringBuffer _buffer = StringBuffer();
  Timer? _timer;

  final RxBool isSearching = false.obs;

  /// =========================
  /// HANDLE SCANNER KEY INPUT
  /// =========================
  void handleKey(KeyDownEvent event) {
    final key = event.logicalKey;
    final character = event.character;

    /// ENTER = scanner completed
    if (key == LogicalKeyboardKey.enter) {
      final barcode = _buffer.toString().trim();

      _clear();

      if (barcode.isNotEmpty) {
        searchProduct(barcode);
      }

      return;
    }

    /// collect scanner characters
    if (character != null && character.isNotEmpty) {
      _buffer.write(character);

      /// auto trigger if scanner no enter key
      _timer?.cancel();

      _timer = Timer(const Duration(milliseconds: 500), () {
        final barcode = _buffer.toString().trim();

        _clear();

        if (barcode.length >= 4) {
          searchProduct(barcode);
        }
      });
    }
  }

  void _clear() {
    _buffer.clear();
    _timer?.cancel();
  }

  /// =========================
  /// DEBUG TOAST
  /// =========================
  void showLog(String message, {Color background = Colors.black87}) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.rawSnackbar(
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: background,
      margin: const EdgeInsets.all(10),
      borderRadius: 12,
      duration: const Duration(seconds: 1),
    );
  }

  /// =========================
  /// SEARCH PRODUCT
  /// =========================
  Future<void> searchProduct(String barcode) async {
    if (isSearching.value) return;
    final productRepo = Get.find<ProductRepo>();

    try {
      isSearching.value = true;
      showLog('🔍 Scanning : $barcode', background: Colors.blue);

      /// simulate api loading
      await Future.delayed(const Duration(seconds: 1));

      /// simulate not found
      if (barcode == '0000') {
        showLog('❌ Product not found', background: Colors.red);
        return;
      }

      var result = await productRepo.getProductByBarcode(barcode);
      if (result == null) {
        showLog('❌ Product not found', background: Colors.red);
        return;
      } else {}

      /// simulate found product
      final product = ProductModel(
        barcode: barcode,
        name: result.nameKh ?? result.nameEn ?? 'Unknown',
        price: (result.price ?? 0.0).toString(),
        imageUrl: ' ${result.thumbnailImage?.thumbnailFilePath}',
      );

      showLog('✅ ${product.name} found', background: Colors.green);
      Get.delete<ProductDetailLogic>();
      Get.toNamed(
        AppRoute.productDetail,
        arguments: result,
        preventDuplicates: false,
      );
    } catch (e) {
      showLog('🔥 Error : $e', background: Colors.orange);
    } finally {
      isSearching.value = false;
    }
  }
}

/// =========================
/// PRODUCT MODEL
/// =========================
class ProductModel {
  final String barcode;
  final String name;
  final String price;
  final String imageUrl;

  ProductModel({
    required this.barcode,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      barcode: json['barcode']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }
}

/// =========================
/// GLOBAL LISTENER
/// =========================
class GlobalBarcodeListener extends StatefulWidget {
  final Widget child;

  const GlobalBarcodeListener({super.key, required this.child});

  @override
  State<GlobalBarcodeListener> createState() => _GlobalBarcodeListenerState();
}

class _GlobalBarcodeListenerState extends State<GlobalBarcodeListener> {
  final FocusNode _focusNode = FocusNode();

  final BarcodeScannerService scannerService = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          scannerService.handleKey(event);
        }

        /// keep focus forever
        if (!_focusNode.hasFocus) {
          _focusNode.requestFocus();
        }
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

/// =========================
/// PRODUCT BOTTOM SHEET
/// =========================
class ProductBottomSheet extends StatelessWidget {
  final ProductModel product;

  const ProductBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.imageUrl,
              height: 140,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          /// NAME
          Text(
            product.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          /// BARCODE
          Text('Barcode : ${product.barcode}'),

          const SizedBox(height: 8),

          /// PRICE
          Text(
            '\$${product.price}',
            style: const TextStyle(
              fontSize: 28,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          /// CLOSE BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
