class JsonUtils {
  /// Converts a list of JSON maps to a list of model objects
  static List<T> fromList<T>(
    List<dynamic> jsonList,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Converts a list of model objects to a list of JSON maps
  static List<Map<String, dynamic>> toList<T>(
    List<T> objectList,
    Map<String, dynamic> Function(T) toJson,
  ) {
    return objectList.map((item) => toJson(item)).toList();
  }
}
