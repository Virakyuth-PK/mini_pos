import 'package:flutter/foundation.dart';

enum Flavor { prd, dev }

class FConfig {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;
  static var telegramChatId = "1002259982134";
  static var telegramToken = "8152749827:AAEwoFovsAqNOjT38dH6koEmIa1Z2pKo_o8";
  static var prdTopicId = "90025"; // prd production
  static var developTopicId = "1049"; // Developing topic

  static String get title {
    switch (appFlavor) {
      case Flavor.prd:
        return 'Mini Pos';
      case Flavor.dev:
        return 'Mini Pos DEV';
    }
  }

  /// Gets the anonymous API key for mall services based on the current flavor.
  static String get cacheManagerKey {
    switch (appFlavor) {
      case Flavor.prd:
        return 'PRD-cache2026ManagerCMGKeyPRPO';
      case Flavor.dev:
        return 'DEV-cache2026ManagerCMGKeyPRPO';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.prd:
        return 'https://hrportal-api.chipmong.com';
      case Flavor.dev:
        return 'https://api-supermarket.chipmongretail.com:8081';
    }
  }

  static String get telegramTopicId {
    if (kDebugMode) {
      return developTopicId;
    } else {
      return prdTopicId;
    }
  }
}
