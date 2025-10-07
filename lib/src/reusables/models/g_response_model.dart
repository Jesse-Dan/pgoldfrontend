import 'package:equatable/equatable.dart';

typedef FromJson<T> = T Function(dynamic json);

class GResponse<T> extends Equatable {
  const GResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.error,
  });

  /// True or false status indicator
  final bool? status;
  static const String statusKey = "status";

  /// HTTP-like or custom status code
  final int? statusCode;
  static const String statusCodeKey = "statusCode";

  /// Server message (success or failure)
  final String? message;
  static const String messageKey = "message";

  /// Parsed data payload (generic)
  final T? data;
  static const String dataKey = "data";

  /// Error details (if any)
  final dynamic error;
  static const String errorKey = "error";

  /// Create a new instance with optional overrides
  GResponse<T> copyWith({
    bool? status,
    int? statusCode,
    String? message,
    T? data,
    dynamic error,
  }) {
    return GResponse<T>(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  /// ✅ Parse response from JSON map
  factory GResponse.fromJson(
    Map<String, dynamic> json, [
    FromJson<T>? fromJsonT,
  ]) {
    final dynamic rawData = json[dataKey];
    return GResponse<T>(
      status: json[statusKey] as bool?,
      statusCode: json[statusCodeKey] as int?,
      message: json[messageKey] as String?,
      data: _parseData(rawData, fromJsonT),
      error: json[errorKey],
    );
  }

  /// Convert object back to JSON
  Map<String, dynamic> toJson() {
    return {
      statusKey: status,
      statusCodeKey: statusCode,
      messageKey: message,
      dataKey: _convertToJson(data),
      errorKey: error,
    };
  }

  @override
  String toString() =>
      'GResponse(status: $status, statusCode: $statusCode, message: $message, data: $data, error: $error)';

  @override
  List<Object?> get props => [status, statusCode, message, data, error];

  // ---- Internal parsing helpers ----

  static dynamic _convertToJson<T>(T? data) {
    if (data == null) return null;
    if (data is List ||
        data is Map ||
        data is num ||
        data is String ||
        data is bool) {
      return data;
    } else if (data is HasToJson) {
      return data.toJson();
    }
    return data;
  }

  static T? _parseData<T>(dynamic rawData, FromJson<T>? fromJsonT) {
    if (rawData == null) {
      if (T == List || T.toString().startsWith("List")) return [] as T;
      return null;
    }
    if (fromJsonT != null) return fromJsonT(rawData);
    return rawData as T?;
  }
}

abstract class HasToJson {
  dynamic toJson();
}
