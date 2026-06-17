class TrendingModel {
  String? id;
  String? title;
  double? rating;
  int? totalSold;
  double? mrp;
  double? flashSalePrice;
  String? imageUrl;

  TrendingModel({
    this.id,
    this.title,
    this.rating,
    this.totalSold,
    this.mrp,
    this.flashSalePrice,
    this.imageUrl,
  });

  factory TrendingModel.fromJson(Map<String, dynamic> json) {
    return TrendingModel(
      id: json['_id'],
      title: json['title'],
      rating: (json['rating'] ?? 0).toDouble(),
      totalSold: json['totalSold'] ?? 0,
      mrp: (json['mrp'] ?? 0).toDouble(),
      flashSalePrice:
      (json['flashSalePrice'] ?? json['minPrice'] ?? 0).toDouble(),
      imageUrl: json['images'] != null &&
          (json['images'] as List).isNotEmpty
          ? json['images'][0]['url']
          : '',
    );
  }

  double get discountPercent {
    if (mrp == null || flashSalePrice == null || mrp == 0) return 0;

    return ((mrp! - flashSalePrice!) / mrp! * 100);
  }
}