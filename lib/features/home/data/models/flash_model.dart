class FlashSaleModel {
  final String id;
  final String title;
  final String imageUrl;
  final double flashSalePrice;
  final double mrp;
  final int totalSold;
  final double rating;
  final String flashSaleEnd;

  FlashSaleModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.flashSalePrice,
    required this.mrp,
    required this.totalSold,
    required this.rating,
    required this.flashSaleEnd,
  });

  factory FlashSaleModel.fromJson(Map<String, dynamic> json) {
    return FlashSaleModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: (json['images'] != null &&
          (json['images'] as List).isNotEmpty)
          ? json['images'][0]['url']
          : '',
      flashSalePrice:
      (json['flashSalePrice'] ?? json['minPrice'] ?? 0).toDouble(),
      mrp: (json['mrp'] ?? 0).toDouble(),
      totalSold: json['totalSold'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      flashSaleEnd: json['flashSaleEnd'] ?? '',
    );
  }

  String get discountPercent {
    if (mrp <= 0 || flashSalePrice <= 0) return "0% OFF";

    final discount =
    (((mrp - flashSalePrice) / mrp) * 100).round();

    return "$discount% OFF";
  }
}