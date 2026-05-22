import 'dart:async';
import 'dart:io';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';
import '../../../../translation/app_locale.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_ext.dart';
import '../../../utils/text_size.dart';
import '../../../utils/x_snackbar.dart';
import '../telegram.dart';
import 'exception.dart';
import 'status_category.dart';

class ExceptionHandler {
  /// Handles various types of exceptions and returns a corresponding [BaseException].
  static BaseException handle(
    dynamic error, {
    http.BaseRequest? request,
    required StatusCategory statusCategory,
  }) {
    BaseException exception;
    if (error is http.Response || error is ApiException) {
      exception = _handleHttpException(error);
    } else if (error is SocketException ||
        error is http.ClientException ||
        error is TimeoutException) {
      exception = NetworkException(
        message: AppLocale.noInternetConnectionDesc.tr,
      );
    } else {
      exception = AppException(message: error.message);
    }

    // Handle different status categories
    final snackBarConfig = {
      StatusCategory.warning: {
        'title': AppLocale.warning.tr,
        'backgroundColor': AppColor.warningColor,
      },
      StatusCategory.error: {
        'title': AppLocale.technicalError.tr,
        'backgroundColor': AppColor.errorColor,
      },
      StatusCategory.localDb: {
        'title': AppLocale.appTechnicalError.tr,
        'backgroundColor': AppColor.errorColor.withAlpha(30),
      },
    };

    final config = snackBarConfig[statusCategory];
    if (config != null) {
      xSnackBar(
        title: config['title'] as String,
        message: exception.message.toString(),
        backgroundColor: (config['backgroundColor'] as Color?),
        textColor: Colors.white,
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 25.d,
          color: Colors.white,
        ),
      );

      sendApiErrorMessage(
        cUrl: request?.getCURL ?? "",
        api: '${http.Response}, statusCode: ${exception.statusCode}',
        urlEndPoint: request?.url.toString().apiEndpointPath ?? "",
        statusCategory: statusCategory,
      );
    }
    return exception;
  }

  /// Handles HTTP-specific exceptions and returns a corresponding [ApiException].
  static ApiException _handleHttpException(dynamic error) {
    final statusCode = error.statusCode;
    final body = error.body;

    if (body == null) {
      return _getApiExceptionFromStatusCode(statusCode);
    } else {
      return ApiException(
        statusCode: statusCode,
        message: getErrorMessage(body, AppLocale.technicalError.tr),
      );
    }
  }

  /// Returns an [ApiException] based on the HTTP status code.
  static ApiException _getApiExceptionFromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiException(
          statusCode: statusCode,
          message: getErrorMessage(null, "Bad Request"),
        );
      case 401:
        return ApiException(
          statusCode: statusCode,
          message: getErrorMessage(null, "Unauthorised Request"),
        );
      case 403:
        return ApiException(
          statusCode: statusCode,
          message: getErrorMessage(null, "Request Forbidden"),
        );
      case 404:
        return ApiException(
          statusCode: statusCode,
          message: getErrorMessage(null, "Request Not Found"),
        );
      case 409:
        return ApiException(
          statusCode: statusCode,
          message: getErrorMessage(null, "Request Conflict"),
        );
      case 408:
        return ApiException(
          statusCode: statusCode,
          message: getErrorMessage(null, "Request Timeout"),
        );
      case 422:
        return ApiException(
          statusCode: statusCode,
          message: "Un-processable Entity",
        );
      case 500:
        return ApiException(
          statusCode: statusCode,
          message: "Internal Server Error",
        );
      case 501:
        return ApiException(
          statusCode: statusCode,
          message: "Server Not Implemented",
        );
      case 502:
        return ApiException(
          statusCode: statusCode,
          message: "Service Unavailable",
        );
      case 503:
        return ApiException(
          statusCode: statusCode,
          message: "Service Unavailable",
        );
      case 504:
        return ApiException(
          statusCode: statusCode,
          message: "Gate Way Time Out",
        );
      case 204:
        return ApiException(statusCode: statusCode, message: "No Content");
      default:
        return ApiException(
          statusCode: statusCode,
          message: getErrorMessage(null, "Response Unknown"),
        );
    }
  }

  /// Extracts an error message from the response body or returns a default message.
  static String getErrorMessage(dynamic data, String defaultMessage) {
    String error = defaultMessage;
    if (data is Map?) {
      if (data?["message"] is String) {
        error = data?["message"];
      } else if (data?["Message"] is String) {
        error = data?["Message"];
      } else if (data?["detail"] is String) {
        error = data?["detail"];
      }
    }
    return error;
  }
}
