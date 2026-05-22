import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';
import '../../../../flavors.dart';
import '../../../global_widgets/x_button.dart';
import '../../../utils/app_ext.dart';
import '../../../utils/app_log.dart';

/// Custom HTTP client with support for request and response interceptors,
/// as well as logging requests and responses with cURL command generation for easy debugging.
class InterceptorClient extends http.BaseClient {
  final http.Client _inner;
  final RequestInterceptor? requestInterceptor;
  final ResponseInterceptor? responseInterceptor;

  /// Constructor for [InterceptorClient].
  ///
  /// Parameters:
  /// - `_inner` (http.Client): The underlying HTTP client used to make requests.
  /// - `requestInterceptor` (RequestInterceptor?): Optional interceptor to modify outgoing requests.
  /// - `responseInterceptor` (ResponseInterceptor?): Optional interceptor to modify incoming responses.
  InterceptorClient(
    this._inner, {
    this.requestInterceptor,
    this.responseInterceptor,
  });

  /// Sends an HTTP request, applying request and response interceptors if provided, and logs the request and response.
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      // Intercept the request if interceptor is provided
      if (requestInterceptor != null) {
        request = await requestInterceptor!.interceptRequest(request);
      }

      // Log the request
      if (kDebugMode) {
        _logRequest(request);
      }

      // Send the request and get the response
      final response = await _inner.send(request);

      // Log the response
      if (kDebugMode) {
        _logResponse(response, request);
      }

      // Intercept the response if interceptor is provided
      if (responseInterceptor != null) {
        return await responseInterceptor!.interceptResponse(response);
      }

      return response;
    } catch (e) {
      // Handle any errors that occur during the request/response process
      if (kDebugMode) {
        xPrettyLog(message: 'Error in InterceptorClient: $e');
      }
      rethrow;
    }
  }

  /// Logs the HTTP request details, including the generated cURL command for debugging.
  void _logRequest(http.BaseRequest request) {
    xPrettyLog(
      message:
          'Log Request 🇰🇭🛫'
          '\nRequest: ${request.method} ${request.url}'
          '\nHeaders: ${request.headers}'
          '\nBody: ${request is http.Request ? request.body : 'Streamed'}'
          // '\nStackTrace: ${StackTrace.current}'
          '\n\n',
      customMessage1LineEnd: '\n📎 🛜 curlCommand: ${request.getCURL}',
    );
  }

  /// Logs the HTTP response details, including status and headers.
  ///
  /// Parameters:
  /// - `response` (http.StreamedResponse): The HTTP response to log.
  void _logResponse(http.StreamedResponse response, http.BaseRequest request) {
    var curlCommand = request.getCURL;
    var message =
        'Log Response 🇰🇭🛬'
        '\nRequest: ${response.request?.method} ${response.request?.url}'
        '\nHeaders: ${response.headers}'
        // '\nStackTrace: ${StackTrace.current}'
        '\nResponse Status: ${response.statusCode} ${response.reasonPhrase}';
    xPrettyLog(
      message: message,
      customMessage1LineEnd: '\n📎 🛜 curlCommand: $curlCommand',
    );
  }
}

/// Interface for defining a request interceptor.
abstract class RequestInterceptor {
  /// Method to intercept and modify the outgoing HTTP request.
  ///
  /// Parameters:
  /// - `request` (http.BaseRequest): The original HTTP request.
  ///
  /// Returns:
  /// - A [Future] of [http.BaseRequest] which could be modified before sending.
  Future<http.BaseRequest> interceptRequest(http.BaseRequest request);
}

/// Interface for defining a response interceptor.
abstract class ResponseInterceptor {
  /// Method to intercept and modify the incoming HTTP response.
  ///
  /// Parameters:
  /// - `response` (http.StreamedResponse): The original HTTP response.
  ///
  /// Returns:
  /// - A [Future] of [http.StreamedResponse] which could be modified before returning.
  Future<http.StreamedResponse> interceptResponse(
    http.StreamedResponse response,
  );
}
