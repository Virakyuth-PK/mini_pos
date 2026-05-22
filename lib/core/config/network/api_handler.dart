import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../utils/app_log.dart';
import 'exception/exception.dart';
import 'exception/exception_handler.dart';
import 'exception/status_category.dart';
import 'http_client.dart';
import 'interceptor/api_interceptor.dart';
import 'interceptor/interceptor_client.dart';
import 'method.dart';
import 'paging.dart';
import 'typedefs.dart';

class ApiHandler<T> {
  final T Function(dynamic value) converter;
  final String method;

  ApiHandler({required this.method, required this.converter});

  //region Method
  factory ApiHandler.get({required T Function(dynamic value) converter}) =>
      ApiHandler<T>(converter: converter, method: Method.GET);

  factory ApiHandler.post({required T Function(dynamic value) converter}) =>
      ApiHandler<T>(converter: converter, method: Method.POST);

  factory ApiHandler.put({required T Function(dynamic value) converter}) =>
      ApiHandler<T>(converter: converter, method: Method.PUT);

  factory ApiHandler.patch({required T Function(dynamic value) converter}) =>
      ApiHandler<T>(converter: converter, method: Method.PATCH);

  factory ApiHandler.delete({required T Function(dynamic value) converter}) =>
      ApiHandler<T>(converter: converter, method: Method.DELETE);

  factory ApiHandler.head({required T Function(dynamic value) converter}) =>
      ApiHandler<T>(converter: converter, method: Method.HEAD);

  factory ApiHandler.options({required T Function(dynamic value) converter}) =>
      ApiHandler<T>(converter: converter, method: Method.OPTIONS);

  //endregion

  //region Request Function
  Future<T?> execute({
    required OnComplete<T> onComplete,
    OnFail? onFail,
    Future<void> Function()? onFinished,
    bool isAuthenticated = true,
    required String endPoint,
    JSON? body,
    dynamic bodyDynamic,
    JSON? formData,
    JSON? queryParams,
    String? customApikey,
    String? customApikeyTag,
    bool isDisableException = false,
  }) async {
    return await _executeRequest<T>(
      onComplete: onComplete,
      onFail: onFail,
      onFinished: onFinished,
      isAuthenticated: isAuthenticated,
      endPoint: endPoint,
      body: body,
      bodyDynamic: bodyDynamic,
      formData: formData,
      queryParams: queryParams,
      customApikey: customApikey,
      customApikeyTag: customApikeyTag,
      isDisableException: isDisableException,
    );
  }

  Future<Paging<T>?> executePaging<T>({
    required OnComplete<Paging<T>?> onComplete,
    OnFail? onFail,
    Future<void> Function()? onFinished,
    bool isAuthenticated = true,
    required String endPoint,
    JSON? body,
    dynamic bodyDynamic,
    JSON? formData,
    JSON? queryParams,
    String? customApikey,
    String? customApikeyTag,
    bool? isDisableException = false,
  }) async {
    return await _executeRequest<T>(
      onCompletePaging: onComplete,
      onFail: onFail,
      onFinished: onFinished,
      isAuthenticated: isAuthenticated,
      endPoint: endPoint,
      body: body,
      formData: formData,
      queryParams: queryParams,
      customApikey: customApikey,
      customApikeyTag: customApikeyTag,
      isPaging: true,
    );
  }

  //endregion

  Future<dynamic> _executeRequest<T>({
    OnComplete<T>? onComplete,
    OnComplete<Paging<T>>? onCompletePaging,
    OnFail? onFail,
    Future<void> Function()? onFinished,
    required bool isAuthenticated,
    required String endPoint,
    JSON? body,
    dynamic bodyDynamic,
    JSON? formData,
    JSON? queryParams,
    String? customApikey,
    String? customApikeyTag,
    bool isPaging = false,
    bool isDisableException = false,
  }) async {
    final client = await _prepareClient(
      isAuthenticated: isAuthenticated,
      apiKey: customApikey,
      apiKeyTag: customApikeyTag,
    );

    try {
      final request = await _buildRequest(
        method: method,
        endPoint: endPoint,
        body: body,
        bodyDynamic: bodyDynamic,
        formData: formData,
        queryParams: queryParams,
      );

      http.StreamedResponse? response = await client
          .send(request)
          .timeout(const Duration(seconds: 30));
      // await client.send(request).timeout(const Duration(seconds: 10));

      final responseBody = await _streamToByte(response.stream);
      if (responseBody.isEmpty) {
        if (onFail != null) {
          return await onFail(
            ExceptionHandler.handle(
              request: request,
              statusCategory: _getStatusCategory(response.statusCode),
              ApiException(statusCode: response.statusCode, message: ""),
            ),
          );
        } else {
          // purpose: throw to catch on line 181 (below) and detection type of exception
          throw CustomFormatException(request: request, response: response);
        }
      }
      var jsonResponse;
      try {
        jsonResponse = jsonDecode(responseBody);
      } catch (e) {
        return jsonResponse = responseBody;
      }

      if (_getStatusCategory(response.statusCode) case StatusCategory.valid) {
        final data = isPaging
            ? Paging<T>.fromMap(jsonResponse, type: T)
            : converter(jsonResponse);
        return isPaging
            ? await onCompletePaging!(data as Paging<T>)
            : await onComplete!(data as T);
      } else if (_getStatusCategory(response.statusCode)
          case StatusCategory.warning) {
        if (isDisableException == false) {
          await _handleWarning(response, request, jsonResponse, onFail);
        }
      } else if (_getStatusCategory(response.statusCode)
          case StatusCategory.error) {
        await _handleError(request, response, jsonResponse, onFail);
      }
    } on CustomFormatException catch (e) {
      ExceptionHandler.handle(
        request: e.request,
        statusCategory: _getStatusCategory(e.response?.statusCode ?? 500),
        ApiException(statusCode: e.response?.statusCode, message: ""),
      );
    } on http.ClientException catch (e) {
      // sendApiErrorMessage(
      //   mobile: "$e. ClientException",
      // );
      if (onFail != null) {
        await onFail(
          ExceptionHandler.handle(
            statusCategory: StatusCategory.error,
            http.ClientException('Socket error: ${e.message}, ClientException'),
          ),
        );
      } else {
        rethrow;
      }
    } catch (error, stack) {
      xPrettyLog(message: "$error\n$stack");
      if (onFail != null) {
        await onFail(
          ExceptionHandler.handle(error, statusCategory: StatusCategory.error),
        );
      } else {
        throw Future.error(error);
      }
    } finally {
      client.close();
      if (onFinished != null) {
        await onFinished();
      }
    }
    return null;
  }

  Future<void> _handleWarning(
    http.StreamedResponse response,
    http.BaseRequest request,
    dynamic jsonResponse,
    OnFail? onFail,
  ) async {
    if (response.statusCode == 307) {
      final newUrl = response.headers['location'];
      if (newUrl != null) {
        final redirectedResponse = await http.get(Uri.parse(newUrl));
        xLog(
          message:
              'Redirected to $newUrl, status: ${redirectedResponse.statusCode}',
        );
      }
    }
    final warning = ApiException(
      statusCode: response.statusCode,
      message: "Warning from API",
      body: jsonResponse,
      statusCategory: StatusCategory.warning,
    );
    if (onFail != null) {
      await onFail(
        ExceptionHandler.handle(
          warning,
          request: request,
          statusCategory: StatusCategory.warning,
        ),
      );
    } else {
      ExceptionHandler.handle(
        warning,
        request: request,
        statusCategory: StatusCategory.warning,
      );
    }
  }

  Future<void> _handleError(
    http.BaseRequest request,
    http.StreamedResponse response,
    dynamic jsonResponse,
    OnFail? onFail,
  ) async {
    // sendApiErrorMessage(
    //   cUrl: request.getCURL,
    //   api: '$jsonResponse ,statusCode : ${response.statusCode}',
    // );
    final error = ApiException(
      statusCode: response.statusCode,
      message: "Error from API",
      body: jsonResponse,
      statusCategory: StatusCategory.error,
    );
    if (onFail != null) {
      await onFail(
        ExceptionHandler.handle(
          error,
          request: request,
          statusCategory: StatusCategory.error,
        ),
      );
    } else {
      ExceptionHandler.handle(
        error,
        request: request,
        statusCategory: StatusCategory.error,
      );
    }
  }

  Future<String> _streamToByte(Stream<List<int>> stream) async {
    final bytes = <int>[];
    await for (final chunk in stream) {
      bytes.addAll(chunk);
    }
    return utf8.decode(bytes);
  }

  Future<http.BaseClient> _prepareClient({
    required bool isAuthenticated,
    String? apiKey,
    String? apiKeyTag,
  }) async {
    final interceptorClient = InterceptorClient(
      http.Client(),
      responseInterceptor: Get.find<ApiInterceptor>(),
    );

    final accessToken = "";
    return isAuthenticated
        ? AuthHttpClient(
            interceptorClient,
            token: accessToken,
            customApikey: apiKey,
            customApikeyTag: apiKeyTag,
          )
        : NormalHttpClient(interceptorClient);
  }

  Future<http.BaseRequest> _buildRequest({
    required String method,
    required String endPoint,
    JSON? body,
    JSON? formData,
    JSON? queryParams,
    dynamic bodyDynamic,
  }) async {
    Uri uri = Uri.parse(endPoint);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    if (formData != null) {
      final multipartRequest = http.MultipartRequest(method, uri)
        ..headers['Content-Type'] = 'multipart/form-data';

      for (final entry in formData.entries) {
        final key = entry.key;
        final value = entry.value;
        if (value is List<XFile>) {
          for (final file in value) {
            final resultFile = await http.MultipartFile.fromPath(
              key,
              file.path,
            );
            xPrettyLog(
              message: "resultFile: ${resultFile.runtimeType.toString()}",
            );
            multipartRequest.files.add(resultFile);
          }
        } else {
          multipartRequest.fields[key] = value.toString();
        }
      }

      return multipartRequest;
    }

    final request = http.Request(method, uri);

    if (body != null || bodyDynamic != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body ?? bodyDynamic);
    }

    return request;
  }

  StatusCategory _getStatusCategory(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return StatusCategory.valid;
    } else if (statusCode >= 300 && statusCode <= 404) {
      return StatusCategory.warning;
    } else {
      return StatusCategory.error;
    }
  }
}
