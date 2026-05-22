import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import '../../../flavors.dart';
import '../../utils/app_ext.dart';
import '../../utils/app_log.dart';
import 'exception/status_category.dart';

Future<String> getPlatformVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return 'Version: ${packageInfo.version} | Build: ${packageInfo.buildNumber}';
}

Future<void> sendApiErrorMessage({
  String? cUrl,
  String? api,
  String? urlEndPoint,
  String? mobile,
  StatusCategory? statusCategory,
}) async {
  // Check for sensitive content
  final sensitiveKeywords = ['password', 'pincode', 'pin'];
  final combinedInputs = '${cUrl ?? ''} ${api ?? ''} ${mobile ?? ''}'
      .toLowerCase();

  if (sensitiveKeywords.any((keyword) => combinedInputs.contains(keyword))) {
    return;
  }

  String platformInfo = await getPlatformVersion();

  // Replace < and > with HTML entities
  mobile = mobile?.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
  urlEndPoint = urlEndPoint?.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
  cUrl = cUrl?.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
  api = api?.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
  platformInfo = platformInfo.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

  var messageTelegram =
      '''
  🔔 <b><u>${FConfig.title} - API Request Failed</u></b>

<blockquote>
  ${kDebugMode ? '🛠️ DEVELOPMENT MODE\n' : ''}<b>${getStatusIcon(statusCategory)} Status:</b>
  #${statusCategory?.name.toUpperCase() ?? "UNKNOWN"}_${FConfig.title.removeAllWhitespace}
</blockquote>

📲 <b>Device Info:</b>          
<blockquote>
<b>Platform:</b> ${Platform.isIOS ? "iOS" : "Android"}
<b>App Info:</b>
<code>$platformInfo</code>
</blockquote>
''';

  if (cUrl != null && cUrl.isNotEmpty) {
    messageTelegram +=
        '''
    
📤 <b>Request (cURL) – <i>Click to copy</i>:</b>

<b>Endpoint:</b>
$urlEndPoint

<b>Hashtag:</b> #${urlEndPoint?.apiEndpointHashtag}
<pre>$cUrl</pre>
''';
  }

  if (api != null && api.isNotEmpty) {
    messageTelegram +=
        '''
    
🧾 <b>API Response – <i>Click to copy</i>:</b>
<pre>$api</pre>
''';
  }

  if (mobile != null && mobile.isNotEmpty) {
    messageTelegram +=
        '''
    
📱 <b>Mobile Exception – <i>Click to copy</i>:</b>
<pre>Exception: $mobile</pre>
''';
  }

  messageTelegram +=
      '''
📌 Please investigate and resolve the issue. 🔍

#${FConfig.title.removeAllWhitespace} #APIError #${FConfig.appFlavor?.name}Alert #CMG
''';

  // Send message to Telegram
  await sendToTelegram(messageTelegram);
}

Future<void> sendToTelegram(String message, {String? topicId}) async {
  String chatId = '-${FConfig.telegramChatId}';
  String botToken = FConfig.telegramToken;
  String topicId = FConfig.telegramTopicId;

  var url = Uri.parse('https://api.telegram.org/bot$botToken/sendMessage');
  // Prepare the request body
  var body = jsonEncode({
    'chat_id': chatId,
    'message_thread_id': topicId,
    'parse_mode': 'HTML',
    'text': message,
  });
  // Send the request
  try {
    var response = await http.post(
      url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      xLog(message: 'Message sent successfully');
    } else {
      xLog(
        message:
            'Failed to send message: ${response.statusCode}\n'
            '${response.request?.getCURL}',
        isFullPrint: true,
      );
    }
  } catch (e) {
    xLog(message: 'Error sending message: $e');
  }
}

String getStatusIcon(StatusCategory? status) {
  switch (status) {
    case StatusCategory.valid:
      return "✅";
    case StatusCategory.warning:
      return "⚠️";
    case StatusCategory.error:
      return "🚨";
    case StatusCategory.localDb:
      return "🗄️";
    default:
      return "❓";
  }
}
