class ReviewRequest {
  final String productId;
  final String vendorId;
  final String orderId;
  final String orderItemId;

  final int rating;
  final String title;
  final String comment;
  final List<String> images;
  final List<String> videos;
  final bool isAnonymous;

  ReviewRequest({
    required this.productId,
    required this.vendorId,
    required this.orderId,
    required this.orderItemId,
    required this.rating,
    required this.title,
    required this.comment,
    required this.images,
    required this.videos,
    required this.isAnonymous,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "vendorId": vendorId,
      "orderId": orderId,
      "orderItemId": orderItemId,
      "rating": rating,
      "title": title,
      "comment": comment,
      "images": images,
      "videos": videos,
      "isAnonymous": isAnonymous,
    };
  }
}