import 'package:get/get.dart';

class AppConst {
  static const String englishCode = "en";
  static const String khmerCode = "km";

  static const String forgetPasswordUrl =
      "https://cmgportal.chipmong.com:8080/Account/ForgotPassword";

  static const int approved = 1;
  static const int blocked = 2;
  static const int completed = 2;
  static const int inProgress = 4;
  static const int pending = 5;
  static const int rejected = 6;
}

//
// 1  approved
// 2  blocked
// 3  completed
// 4  in_progress
// 5  pending
// 6  rejected
// NULL  NULL
