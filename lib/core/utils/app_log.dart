import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../../flavors.dart';
import 'app_ext.dart';

const dataWidth = 500;
const borderWidth = 100;

/// Logs simple debug messages with custom formatting.
/// Displays the file path and line number. Works only in `kDebugMode`.
void xLog({
  required String message,
  String? region,
  bool isFullPrint = false,
  bool isNeedStackTrace = false,
}) {
  if (!kDebugMode) return; // Only log in debug mode

  final border = '=' * borderWidth;
  final header = region != null
      ? '🔍 [$region]'
      : '🐛 LOG || ${DateTime.timestamp().formatTimeNoSpaceToString}\n';
  final callerInfo = _getCallerInfo();

  final formattedMessage = _formatMessage(message, dataWidth);
  final stackTrace = _getStackTrace(isNeedStackTrace);

  if (isFullPrint) {
    _logMessage(border, header, callerInfo, message, isNeedStackTrace);
  } else {
    _logMessage(
      border,
      header,
      callerInfo,
      '$formattedMessage$stackTrace',
      isNeedStackTrace,
    );
  }
}

/// Logs detailed debug messages with custom formatting.
/// Displays the file path, line number, and timestamp. Works only in `kDebugMode`.
void xPrettyLog({
  required String message,
  String? customMessage1LineStart,
  String? customMessage1LineEnd,
  String? region,
  bool isNeedStackTrace = false,
}) {
  if (!kDebugMode) return; // Only log in debug mode

  final callerInfo = _getCallerInfo();
  final border = '=' * borderWidth;
  final header = region != null
      ? '🔍 [$region]'
      : '🐛 PRETTY LOG || ${DateTime.timestamp().formatTimeNoSpaceToString}\n';
  final formattedMessage = _formatMessage(message, dataWidth);
  final stackTrace = _getStackTrace(isNeedStackTrace);

  _logMessage(
    border,
    header,
    callerInfo,
    '${customMessage1LineStart ?? ""}\n$formattedMessage$stackTrace\n${customMessage1LineEnd ?? ""}',
    isNeedStackTrace,
  );
}

/// Helper function to log messages with borders.
void _logMessage(
  String border,
  String header,
  Map<String, String> callerInfo,
  String message,
  bool isNeedStackTrace,
) {
  log(
    '\n$border\n$header\nFile: ${callerInfo['file']} (line ${callerInfo['line']})\n$message\n$border\n',
    time: DateTime.timestamp(),
    zone: Zone.current,
    name: FConfig.title,
    stackTrace: isNeedStackTrace ? StackTrace.current : null,
  );
}

/// Formats the message to fit within the specified width.
String _formatMessage(String message, int maxWidth) {
  final buffer = StringBuffer();
  for (int i = 0; i < message.length; i += maxWidth) {
    buffer.writeln(
      message.substring(
        i,
        i + maxWidth > message.length ? message.length : i + maxWidth,
      ),
    );
  }
  return buffer.toString();
}

/// Retrieves the stack trace if needed.
String _getStackTrace(bool isNeedStackTrace) {
  return isNeedStackTrace ? '\nStackTrace:\n${StackTrace.current}' : '';
}

/// Extracts the caller's full file path and line number from the stack trace.
Map<String, String> _getCallerInfo() {
  final trace = StackTrace.current.toString().split("\n");
  if (trace.length < 3) return {'file': 'unknown', 'line': 'unknown'};

  final targetLine = trace[2];
  final regex = RegExp(r'^(#\d+\s+)(.+?):(\d+):(\d+)');
  final match = regex.firstMatch(targetLine);

  if (match != null) {
    String filePath = match.group(2) ?? 'unknown';
    String lineNumber = match.group(3) ?? 'unknown';

    return {'file': filePath, 'line': lineNumber};
  }
  return {'file': 'unknown', 'line': 'unknown'};
}
