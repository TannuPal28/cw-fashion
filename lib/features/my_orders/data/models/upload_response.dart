class UploadResponse {
  final bool success;
  final List<UploadedFile> files;

  UploadResponse({
    required this.success,
    required this.files,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      success: json["success"] ?? false,
      files: (json["files"] as List? ?? [])
          .map((e) => UploadedFile.fromJson(e))
          .toList(),
    );
  }
}

class UploadedFile {
  final String url;
  final String publicId;
  final String originalName;
  final int size;
  final String mimeType;

  UploadedFile({
    required this.url,
    required this.publicId,
    required this.originalName,
    required this.size,
    required this.mimeType,
  });

  factory UploadedFile.fromJson(Map<String, dynamic> json) {
    return UploadedFile(
      url: json["url"] ?? "",
      publicId: json["publicId"] ?? "",
      originalName: json["originalName"] ?? "",
      size: json["size"] ?? 0,
      mimeType: json["mimeType"] ?? "",
    );
  }
}