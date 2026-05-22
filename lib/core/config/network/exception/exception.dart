import 'package:http/http.dart' as http;

import '../typedefs.dart';
import 'status_category.dart';

/// Base class for all exceptions.
abstract class BaseException implements Exception {
  final int? statusCode;
  final String? message;
  final JSON? body;
  final StatusCategory? statusCategory;

  BaseException({
    this.statusCode,
    this.message,
    this.body,
    this.statusCategory = StatusCategory.warning,
  });

  @override
  String toString() {
    return "$runtimeType: ${message ?? 'No message'}";
  }
}

/// Exception thrown for network-related errors.
class NetworkException extends BaseException {
  NetworkException({super.statusCode, super.message});
}

/// Exception thrown for API-related errors.
class ApiException extends BaseException {
  ApiException({
    super.statusCode,
    super.body,
    super.message,
    super.statusCategory,
  });
}

/// Exception thrown for cache-related errors.
class CacheException extends BaseException {
  CacheException({super.statusCategory, super.message});
}

/// General application exception.
class AppException extends BaseException {
  AppException({super.statusCategory, super.message});
}

/// CustomException request and response of request service

class CustomFormatException implements Exception {
  final http.BaseRequest? request;
  final http.StreamedResponse? response;

  CustomFormatException({required this.request, required this.response});

  @override
  String toString() =>
      'CustomFormatException: Request: $request, Response: ${response?.statusCode}';
}
