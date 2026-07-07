class MyReviewResponse {
  final bool success;
  final List<MyReview> reviews;

  MyReviewResponse({
    required this.success,
    required this.reviews,
  });

  factory MyReviewResponse.fromJson(Map<String, dynamic> json) {
    return MyReviewResponse(
      success: json["success"] ?? false,
      reviews: (json["reviews"] as List? ?? [])
          .map((e) => MyReview.fromJson(e))
          .toList(),
    );
  }
}

class MyReview {
  final String id;
  final String orderItem;
  final int rating;
  final String title;
  final String comment;

  MyReview({
    required this.id,
    required this.orderItem,
    required this.rating,
    required this.title,
    required this.comment,
  });

  factory MyReview.fromJson(Map<String, dynamic> json) {
    return MyReview(
      id: json["_id"] ?? "",
      orderItem: json["orderItem"] ?? "",
      rating: json["rating"] ?? 0,
      title: json["title"] ?? "",
      comment: json["comment"] ?? "",
    );
  }
}