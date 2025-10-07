import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/services/encrypt/encryption_helper.dart';

class HttpManager {
  final String _baseUrl;
  static bool _isTokenExpired = false;

  HttpManager(this._baseUrl);

  static void expireToken() => _isTokenExpired = true;
  static void refireToken() => _isTokenExpired = false;

  Future<String> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool isAuthenticated = false,
    bool isEncrypted = false, // Marker for encryption
  }) async {
    return await _request(
      method: 'GET',
      endpoint: endpoint,
      headers: headers,
      queryParams: queryParams,
      isAuthenticated: isAuthenticated,
      isEncrypted: isEncrypted,
    );
  }

  Future<String> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    bool isAuthenticated = false,
    Map<String, dynamic>? queryParams,
    bool isEncrypted = false, // Marker for encryption
  }) async {
    return await _request(
      method: 'POST',
      endpoint: endpoint,
      headers: headers,
      body: body,
      queryParams: queryParams,
      isAuthenticated: isAuthenticated,
      isEncrypted: isEncrypted,
    );
  }

  Future<String> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    bool isAuthenticated = false,
    Map<String, dynamic>? queryParams,
    bool isEncrypted = false, // Marker for encryption
  }) async {
    return await _request(
      method: 'PUT',
      endpoint: endpoint,
      headers: headers,
      body: body,
      queryParams: queryParams,
      isAuthenticated: isAuthenticated,
      isEncrypted: isEncrypted,
    );
  }

  Future<String> patch(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    bool isAuthenticated = false,
    Map<String, dynamic>? queryParams,
    bool isEncrypted = false,
  }) async {
    return await _request(
      method: 'PATCH',
      endpoint: endpoint,
      headers: headers,
      body: body,
      queryParams: queryParams,
      isAuthenticated: isAuthenticated,
      isEncrypted: isEncrypted,
    );
  }

  Future<String> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool isAuthenticated = false,
    bool isEncrypted = false, // Marker for encryption
  }) async {
    return await _request(
      method: 'DELETE',
      endpoint: endpoint,
      headers: headers,
      queryParams: queryParams,
      isAuthenticated: isAuthenticated,
      isEncrypted: isEncrypted,
    );
  }

  Future<String> uploadFile(
    String endpoint,
    File file, {
    Map<String, String>? headers,
    bool isAuthenticated = false,
  }) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse('$_baseUrl$endpoint'))
            ..files.add(await http.MultipartFile.fromPath('file', file.path))
            ..headers.addAll(_buildHeaders(headers, isAuthenticated));
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      return _processResponse(
        responseData,
        isEncrypted: false,
      ); // No encryption for file upload
    } catch (e) {
      _handleException(e);
    }
    throw Exception('Unexpected error during file upload');
  }

  Future<String> _request({
    required String method,
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    bool isAuthenticated = false,
    bool isEncrypted = false,
  }) async {
    if (isAuthenticated) _checkToken();
    try {
      log('HttpManager: Sending $method request to $endpoint');
      final uri = Uri.parse(
        '$_baseUrl$endpoint',
      ).replace(queryParameters: queryParams);
      
      log('HttpManager: Sending $method request to ${uri.host}');

      final requestHeaders = _buildHeaders(headers, isAuthenticated);

      // Encrypt body if present and encryption is enabled
      final requestBody = body != null && isEncrypted
          ? EncryptionHelper.encrypt(jsonEncode(body))
          : body != null
              ? jsonEncode(body)
              : null;

      final response = await _sendHttpRequest(
        method: method,
        uri: uri,
        headers: requestHeaders,
        body: requestBody,
      );

      return _processResponse(response, isEncrypted: isEncrypted);
    } catch (e) {
      _handleException(e);
    }
    throw Exception('Unexpected error in $method request');
  }

  Future<http.Response> _sendHttpRequest({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    dynamic body,
  }) async {
    // log('HttpManager: Sending $method request to ${uri.toString()}');
    // log('HttpManager: Headers: $headers');
    if (body != null) log('HttpManager: Body: $body');
    log('HttpManager: Headers: $headers');

    late http.Response response;
    switch (method) {
      case 'GET':
        response = await http.get(uri, headers: headers);
        break;
      case 'POST':
        response = await http.post(uri, headers: headers, body: body);
        break;
      case 'PATCH':
        response = await http.patch(uri, headers: headers, body: body);
        break;
      case 'PUT':
        response = await http.put(uri, headers: headers, body: body);
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;
      default:
        throw Exception('Unsupported HTTP method: $method');
    }

    log('HttpManager: Response Status Code: ${response.statusCode}');
    log('HttpManager: Response Body: ${response.body}');
    return response;
  }

  String _processResponse(http.Response response, {required bool isEncrypted}) {
    try {
      if (response.body.isEmpty) {
        throw Exception('Response body is empty');
      }
      final decodedBody =
          isEncrypted ? EncryptionHelper.decrypt(response.body) : response.body;
      log('HttpManager: Response Status Code ${response.statusCode}');

      return decodedBody;
    } catch (e) {
      throw Exception('Response processing failed: $e');
    }
  }

  Map<String, String> _buildHeaders(
    Map<String, String>? additionalHeaders,
    bool isAuthenticated,
  ) {
    final headers = {'Content-Type': 'application/json'};
    if (isAuthenticated) {
      headers['Authorization'] = 'Bearer ${PGoldAuth.instance.authToken}';
    }
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    return headers;
  }

  void _handleException(dynamic e) {
    String message = e.toString();
    if (e is SocketException) {
      throw Exception("Network error. Check your network and try again.");
    } else if (e is FormatException) {
      throw Exception("Invalid or Unfamiliar data format.");
    } else if (e is http.ClientException) {
      throw Exception("Network error. Check your network and try again.");
    } else {
      throw Exception(message);
    }
  }

  void _checkToken() {
    if (_isTokenExpired) {
      throw Exception("Session has expired");
    }
  }
}
