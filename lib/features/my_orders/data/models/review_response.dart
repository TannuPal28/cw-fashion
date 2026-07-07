class ReviewResponse {
  final bool success;

  final Review review;

  ReviewResponse({
    required this.success,
    required this.review,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      success: json["success"] ?? false,
      review: Review.fromJson(json["review"]),
    );
  }
}

class Review {
  final String id;

  final String product;

  final String order;

  final String orderItem;

  final String vendor;

  final int rating;

  final String title;

  final String comment;

  final List<String> images;

  final List<String> videos;

  final bool isAnonymous;

  Review({
    required this.id,
    required this.product,
    required this.order,
    required this.orderItem,
    required this.vendor,
    required this.rating,
    required this.title,
    required this.comment,
    required this.images,
    required this.videos,
    required this.isAnonymous,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["_id"] ?? "",
      product: json["product"] ?? "",
      order: json["order"] ?? "",
      orderItem: json["orderItem"] ?? "",
      vendor: json["vendor"] ?? "",
      rating: json["rating"] ?? 0,
      title: json["title"] ?? "",
      comment: json["comment"] ?? "",
      images:
      (json["images"] as List? ?? []).map((e) => e.toString()).toList(),
      videos:
      (json["videos"] as List? ?? []).map((e) => e.toString()).toList(),
      isAnonymous: json["isAnonymous"] ?? false,
    );
  }
}