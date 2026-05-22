import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart' as http;
import '../../../../flavors.dart';
import '../../../app/logic.dart';
import '../../../utils/app_log.dart';
import '../typedefs.dart';
import 'interceptor_client.dart';

/// Interceptor to handle API responses, particularly unauthorized (401) responses.
class ApiInterceptor implements ResponseInterceptor {
  @override
  Future<http.StreamedResponse> interceptResponse(
    http.StreamedResponse response,
  ) async {
    // Handle response data, error, etc.
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 401:
        {
          // Show loading indicator while refreshing the token
          EasyLoading.show(status: 'Refreshing token...');
          try {
            final newResponse = await _unauthorizedHandler(response);
            EasyLoading.dismiss();
            return newResponse;
          } catch (e) {
            EasyLoading.dismiss();
            _showExpiredTokenDialog();
            rethrow;
          }
        }
      default:
        return response;
    }
  }

  /// Retries the original request with the new token.
  Future<http.StreamedResponse> _retryRequest(
    http.BaseRequest originalRequest,
    String newToken,
  ) async {
    try {
      if (originalRequest is http.Request) {
        final newRequest = http.Request(
          originalRequest.method,
          originalRequest.url,
        );
        newRequest.headers.addAll(originalRequest.headers);
        newRequest.headers['Authorization'] = 'Bearer $newToken';
        newRequest.body = originalRequest.body;
        newRequest.encoding = originalRequest.encoding;
        return await http.Client().send(newRequest);
      } else if (originalRequest is http.StreamedRequest) {
        final newRequest = http.StreamedRequest(
          originalRequest.method,
          originalRequest.url,
        );
        newRequest.headers.addAll(originalRequest.headers);
        newRequest.headers['Authorization'] = 'Bearer $newToken';
        await originalRequest.finalize().pipe(newRequest.sink);
        return await http.Client().send(newRequest);
      } else {
        throw ArgumentError(
          'Unsupported request type: ${originalRequest.runtimeType}',
        );
      }
    } catch (e) {
      // Handle any errors that occur during the retry process
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to retry request: $e');
      rethrow;
    }
  }

  /// Handles unauthorized (401) responses by refreshing the token and retrying the original request.
  Future<http.StreamedResponse> _unauthorizedHandler(
    http.StreamedResponse response,
  ) async {
    // Call the refresh token API
    final newToken = await _refreshToken();

    // Save the new token
    // var oldLoginResponse = await LoginLocal().getData();
    // oldLoginResponse?.accessToken = newToken['accessToken'];
    // oldLoginResponse?.refreshToken = newToken['refreshToken'];
    // await LoginLocal().setData(oldLoginResponse!);

    // Retry the original request with the new token
    return await _retryRequest(response.request!, newToken['accessToken']);
  }

  /// Calls the refresh token API and returns the new token.
  Future<JSON> _refreshToken() async {
    try {
      xLog(message: 'Starting token refresh process');

      final refreshTokenUrl = '${FConfig.baseUrl}/api/v1/Account/RefreshToken';
      xLog(message: 'Refresh token URL: $refreshTokenUrl');

      xLog(message: 'Retrieving old login response');
      //fix this access token
      final oldLoginResponse = "";

      if (oldLoginResponse == null) {
        xLog(message: 'Old login response is null');
        throw Exception('Old login response is null');
      }

      //fix this access token
      //fix this refresh token
      final accessToken = "";
      final refreshToken = "";
      xLog(message: 'Access Token: $accessToken');
      xLog(message: 'Refresh Token: $refreshToken');

      xLog(message: 'Sending refresh token request');
      final response = await http.post(
        Uri.parse(refreshTokenUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        xLog(message: 'Token refresh successful');
        final responseBody = jsonDecode(response.body);
        xLog(message: 'Response Body: $responseBody');
        return responseBody;
      } else {
        xLog(
          message:
              'Failed to refresh token. Status code: ${response.statusCode}',
        );
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      xLog(message: 'Exception occurred: $e');
      throw Exception('Failed to refresh token');
    }
  }

  void _showExpiredTokenDialog() {
    g.Get.dialog(
      ExpiredTokenDialog(),
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
    );
  }
}

class ExpiredTokenDialog extends StatefulWidget {
  @override
  _ExpiredTokenDialogState createState() => _ExpiredTokenDialogState();
}

class _ExpiredTokenDialogState extends State<ExpiredTokenDialog> {
  int _countdown = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
        _performAction();
      }
    });
  }

  Future<void> _performAction() async {
    g.Get.back(); // Close the dialog
    EasyLoading.dismiss();
    await g.Get.find<AppLogic>().logoutFunction();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Session Expired'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your session has expired. You will be logged out in'),
            SizedBox(height: 10),
            Text(
              '$_countdown seconds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Logout Now'),
            onPressed: () async {
              _timer.cancel();
              await _performAction();
            },
          ),
        ],
      ),
    );
  }
}
