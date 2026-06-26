class RelatedProductsResponse {
  final bool success;
  final List<RelatedProduct> products;

  RelatedProductsResponse({
    required this.success,
    required this.products,
  });

  factory RelatedProductsResponse.fromJson(Map<String, dynamic> json) {
    return RelatedProductsResponse(
      success: json['success'],
      products: (json['products'] as List)
          .map((e) => RelatedProduct.fromJson(e))
          .toList(),
    );
  }
}

class RelatedProduct {
  final String id;
  final String title;
  final String image;
  final double rating;
  final int reviews;
  final int sold;
  final int price;
  final int mrp;

  RelatedProduct({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.sold,
    required this.price,
    required this.mrp,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      image: json['images'] != null &&
          (json['images'] as List).isNotEmpty
          ? json['images'][0]['url']
          : '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['numRatings'] ?? 0,
      sold: json['totalSold'] ?? 0,
      price: json['minPrice'] ?? 0,
      mrp: json['mrp'] ?? 0,
    );
  }
}