import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../translation/app_locale.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';
import '../utils/app_style.dart';
import '../utils/text_size.dart';

enum AppStatus { pending, approved, rejected, blocked, forwarded, unknown }

class XStatusBadge extends StatelessWidget {
  const XStatusBadge({super.key, required this.status});

  final String? status; // API value

  @override
  Widget build(BuildContext context) {
    final parsed = parseStatus(status);
    final config = _getStatusConfig(parsed);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.d, vertical: 2.d),
      decoration: xBoxDecoration(
        color: config.bg,
        borderRadius: BorderRadius.circular(19.d),
      ),
      child: Text(
        config.label,
        style: XTextStyle.regular(fontSize: XFontSize.xS12, color: config.text),
      ),
    );
  }
}

AppStatus parseStatus(String? value) {
  switch (value?.toLowerCase()) {
    case 'pending':
      return AppStatus.pending;
    case 'approved':
      return AppStatus.approved;
    case 'rejected':
      return AppStatus.rejected;
    case 'blocked':
      return AppStatus.blocked;
    case 'forwarded':
      return AppStatus.forwarded;
    default:
      return AppStatus.unknown;
  }
}

_StatusConfig _getStatusConfig(AppStatus status) {
  switch (status) {
    case AppStatus.pending:
      return _StatusConfig(
        label: AppLocale.pending.tr,
        bg: AppColor.pendingColor.withValues(alpha: .15),
        text: AppColor.pendingColor,
      );

    case AppStatus.approved:
      return _StatusConfig(
        label: AppLocale.approved.tr,
        bg: AppColor.completeColor.withValues(alpha: .15),
        text: AppColor.completeColor,
      );

    case AppStatus.rejected:
      return _StatusConfig(
        label: AppLocale.rejected.tr,
        bg: Colors.red.withValues(alpha: .15),
        text: Colors.red,
      );

    case AppStatus.forwarded:
      return _StatusConfig(
        label: AppLocale.forwarded.tr,
        bg: AppColor.approve.withValues(alpha: .15),
        text: AppColor.approve,
      );

    case AppStatus.unknown:
      return _StatusConfig(
        label: AppLocale.unknown.tr,
        bg: Colors.grey.withValues(alpha: .15),
        text: Colors.grey,
      );
    case AppStatus.blocked:
      return _StatusConfig(
        label: AppLocale.blocked.tr,
        bg: AppColor.reject.withValues(alpha: .15),
        text: Colors.red,
      );
  }
}

class _StatusConfig {
  final String label;
  final Color bg;
  final Color text;

  const _StatusConfig({
    required this.label,
    required this.bg,
    required this.text,
  });
}
