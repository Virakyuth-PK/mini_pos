import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_color.dart';

class XRefreshIndicator extends RefreshIndicator {
  XRefreshIndicator({
    super.key,
    required super.child,
    required Future<void> Function() onRefresh,
  }) : super(
         color: primaryColor,
         triggerMode: RefreshIndicatorTriggerMode.anywhere,
         onRefresh: () async {
           HapticFeedback.selectionClick(); // Haptic feedback when refresh is triggered
           await onRefresh(); // Call the original onRefresh function
         },
       );
}
