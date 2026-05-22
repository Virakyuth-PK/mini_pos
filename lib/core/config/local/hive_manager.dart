import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveManager extends GetxService {
  HiveManager();

  static Future<void> init() async {
    // Initialize Hive for the Flutter app
    await Hive.initFlutter();
    // Register adapters for different data models
    // Hive.registerAdapter(ProductItemResponseAdapter());
  }
}
