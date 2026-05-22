import 'package:get/get.dart';

import '../../core/utils/app_const.dart';
import 'khmer_key.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {AppConst.khmerCode: khmerKey};
  }
}
