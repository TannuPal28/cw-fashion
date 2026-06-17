class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String link;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.link,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      imageUrl: json['image']?['url']?.toString() ?? '',
      link: json['link']?.toString() ?? '',
    );
  }
}