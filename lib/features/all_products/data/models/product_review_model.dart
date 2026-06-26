class ProductReviewModel {
  final String id;
  final String userName;
  final double rating;
  final String title;
  final String comment;
  final bool isVerifiedPurchase;
  final bool isAnonymous;
  final int helpfulCount;
  final String createdAt;

  ProductReviewModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.title,
    required this.comment,
    required this.isVerifiedPurchase,
    required this.isAnonymous,
    required this.helpfulCount,
    required this.createdAt,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      id: json["_id"] ?? "",
      userName: json["user"]?["name"] ?? "",
      rating: (json["rating"] ?? 0).toDouble(),
      title: json["title"] ?? "",
      comment: json["comment"] ?? "",
      isVerifiedPurchase: json["isVerifiedPurchase"] ?? false,
      isAnonymous: json["isAnonymous"] ?? false,
      helpfulCount: json["helpfulCount"] ?? 0,
      createdAt: json["createdAt"] ?? "",
    );
  }
}