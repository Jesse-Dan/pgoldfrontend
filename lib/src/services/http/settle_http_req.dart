import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/route_config.dart';
import 'package:pgoldapp/src/modules/login/login_view.dart';
import 'package:pgoldapp/src/reusables/models/g_response_model.dart';
import 'package:pgoldapp/src/reusables/utils/show_loading.dart';
import 'package:pgoldapp/src/services/http/http_manager.dart';

typedef FromJson<T> = T Function(dynamic json);

GResponse<T> settleResponse<T>(
  String responseString, {
  required FromJson<T> fromJsonT,
}) {
  log('[settleResponse] Raw Response: $responseString');

  final Map<String, dynamic>? response = _safeJsonDecode(responseString);

  log('[settleResponse] Decoded JSON: $response');

  _forceOut(responseString);

  if (response == null) {
    log('[settleResponse] Null response. Throwing exception.');
    throw Exception("Invalid or empty JSON response.");
  }

  final int? statusCode = response[GResponse.statusCodeKey];

  log('[settleResponse] Status Code: $statusCode');

  try {
    if (statusCode == null || statusCode < 200 || statusCode >= 300) {
      final extractedError = extractErrorMessage(responseString);
      log('[settleResponse] Request failed. Extracted error: $extractedError');
      throw Exception(extractedError);
    }

    final GResponse<T> result = GResponse<T>.fromJson(response, fromJsonT);

    log('[settleResponse] Response parsed successfully: $result');

    return result;
  } catch (e, stacktrace) {
    log(
      '[settleResponse] ❌ Error occurred - $e\nStacktrace: $stacktrace\nResponseString: $responseString',
    );
    _forceOut(e.toString());
    rethrow;
  }
}

void _forceOut(String e) {
  if (e.contains("Invalid Token.") || e.contains("Token has expired")) {
    log('[forceOut] Unauthenticated detected, performing forced logout.');

    cancelLoading();
    HttpManager.expireToken();

    final currentRoute =
        ModalRoute.of(navigatorKey.currentContext!)?.settings.name;
    log('[forceOut] Current route: $currentRoute');

    if (currentRoute != LoginView.routeName) {
      log('[forceOut] Navigating to LoginView.');
      navigatorKey.currentState?.pushReplacementNamed(LoginView.routeName);
      Map<String, dynamic> message = json.decode(e);
      throw Exception(message['message'] ?? "Session Expired");
    }
  }
}

String extractErrorMessage(String? responseString) {
  log('[extractErrorMessage] Raw input: $responseString');

  try {
    if (responseString == null || responseString.isEmpty) {
      return "Invalid or empty response received.";
    }

    if (!responseString.trim().startsWith('{')) {
      return responseString.trim();
    }

    final Map<String, dynamic>? response = _safeJsonDecode(responseString);
    log('[extractErrorMessage] Parsed JSON: $response');

    if (response == null) {
      return "Failed to parse JSON response. Please contact support.";
    }

    final String generalMessage = response["message"]?.toString().trim() ??
        "An unexpected error occurred.";

    String errorMessage = "";
    if (response.containsKey("error")) {
      if (response["error"] is Map) {
        final Map<String, dynamic> errorMap = response["error"];
        if (errorMap.isNotEmpty) {
          final String firstKey = errorMap.keys.first;
          final List<dynamic>? firstErrorList = errorMap[firstKey];
          if (firstErrorList != null && firstErrorList.isNotEmpty) {
            errorMessage = firstErrorList[0].toString();
          }
        }
      } else if (response["error"] is String) {
        errorMessage = response["error"].toString();
      }
    }

    final result = "$generalMessage. $errorMessage".trim().replaceAll(
          "Exception",
          "",
        );
    log('[extractErrorMessage] Final error message: $result');
    return result;
  } catch (e) {
    log('[extractErrorMessage] JSON parse failed with error: $e');
    return "An error occurred while processing the response. Please try again.";
  }
}

Map<String, dynamic>? _safeJsonDecode(String jsonString) {
  try {
    final decodedJson = jsonDecode(jsonString) as Map<String, dynamic>?;
    log('[safeJsonDecode] Successfully decoded JSON.');
    return decodedJson;
  } catch (e) {
    log('[safeJsonDecode] Failed to decode JSON: $e');
    return null;
  }
}
