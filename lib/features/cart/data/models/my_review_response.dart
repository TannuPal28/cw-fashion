class MyReviewResponse {
  final bool success;
  final List<MyReview> reviews;
  final Pagination pagination;

  MyReviewResponse({
    required this.success,
    required this.reviews,
    required this.pagination,
  });

  factory MyReviewResponse.fromJson(Map<String, dynamic> json) {
    return MyReviewResponse(
      success: json["success"] ?? false,
      reviews: (json["reviews"] as List? ?? [])
          .map((e) => MyReview.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(
        json["pagination"] ?? {},
      ),
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json["page"] ?? 1,
      limit: json["limit"] ?? 20,
      total: json["total"] ?? 0,
      totalPages: json["totalPages"] ?? 1,
    );
  }
}

class MyReview {
  final String id;
  final ProductReview product;
  final String order;
  final String orderItem;
  final String vendor;
  final int rating;
  final String title;
  final String comment;
  final List<String> images;
  final List<String> videos;
  final bool isAnonymous;
  final String status;
  final String createdAt;

  MyReview({
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
    required this.status,
    required this.createdAt,
  });

  factory MyReview.fromJson(Map<String, dynamic> json) {
    return MyReview(
      id: json["_id"] ?? "",
      product: ProductReview.fromJson(
        json["product"] ?? {},
      ),
      order: json["order"] ?? "",
      orderItem: json["orderItem"] ?? "",
      vendor: json["vendor"] ?? "",
      rating: json["rating"] ?? 0,
      title: json["title"] ?? "",
      comment: json["comment"] ?? "",
      images: (json["images"] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      videos: (json["videos"] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      isAnonymous: json["isAnonymous"] ?? false,
      status: json["status"] ?? "",
      createdAt: json["createdAt"] ?? "",
    );
  }
}

class ProductReview {
  final String id;
  final String title;
  final String slug;
  final List<ProductImage> images;

  ProductReview({
    required this.id,
    required this.title,
    required this.slug,
    required this.images,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      slug: json["slug"] ?? "",
      images: (json["images"] as List? ?? [])
          .map((e) => ProductImage.fromJson(e))
          .toList(),
    );
  }
}

class ProductImage {
  final String id;
  final String url;
  final String publicId;
  final bool isPrimary;

  ProductImage({
    required this.id,
    required this.url,
    required this.publicId,
    required this.isPrimary,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json["_id"] ?? "",
      url: json["url"] ?? "",
      publicId: json["publicId"] ?? "",
      isPrimary: json["isPrimary"] ?? false,
    );
  }
}