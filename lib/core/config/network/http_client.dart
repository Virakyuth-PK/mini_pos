import 'package:http/http.dart' as http;
import 'interceptor/interceptor_client.dart';

/// HTTP client that adds an authorization header to each request.
class AuthHttpClient extends http.BaseClient {
  final InterceptorClient _interceptorClient;
  String? customApikey;
  String? customApikeyTag;
  final String token;

  AuthHttpClient(
    this._interceptorClient, {
    required this.token,
    this.customApikey,
    this.customApikeyTag,
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Add the authorization header to the request
    if (customApikey != null) {
      request.headers[customApikeyTag ?? ""] = customApikey ?? "";
    } else {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Send the request using the interceptor client
    return _interceptorClient.send(request);
  }
}

/// HTTP client that does not add any additional headers to the request.
class NormalHttpClient extends http.BaseClient {
  final InterceptorClient _interceptorClient;

  NormalHttpClient(this._interceptorClient);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Send the request using the interceptor client
    return _interceptorClient.send(request);
  }
}
