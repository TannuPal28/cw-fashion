String parseId(dynamic value) {
  if (value == null) return "";

  if (value is String) return value;

  if (value is Map<String, dynamic>) {
    return value["_id"] ?? value["id"] ?? "";
  }

  return "";
}

String parseName(dynamic value, String key) {
  if (value is Map<String, dynamic>) {
    return value[key] ?? "";
  }

  return "";
}