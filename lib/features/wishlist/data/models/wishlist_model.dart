class WishlistResponse {
  final bool success;
  final List<WishlistProduct> wishlist;

  WishlistResponse({
    required this.success,
    required this.wishlist,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      success: json["success"],
      wishlist: List<WishlistProduct>.from(
        json["wishlist"].map((e) => WishlistProduct.fromJson(e)),
      ),
    );
  }
}

class WishlistProduct {
  final String id;
  final String title;
  final double rating;
  final int numRatings;
  final int minPrice;
  final int maxPrice;
  final List<WishlistImage> images;

  WishlistProduct({
    required this.id,
    required this.title,
    required this.rating,
    required this.numRatings,
    required this.minPrice,
    required this.maxPrice,
    required this.images,
  });

  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    return WishlistProduct(
      id: json["_id"],
      title: json["title"],
      rating: (json["rating"] ?? 0).toDouble(),
      numRatings: json["numRatings"] ?? 0,
      minPrice: json["minPrice"] ?? 0,
      maxPrice: json["maxPrice"] ?? 0,
      images: List<WishlistImage>.from(
        json["images"].map((e) => WishlistImage.fromJson(e)),
      ),
    );
  }
}

class WishlistImage {
  final String url;

  WishlistImage({
    required this.url,
  });

  factory WishlistImage.fromJson(Map<String, dynamic> json) {
    return WishlistImage(
      url: json["url"],
    );
  }
}