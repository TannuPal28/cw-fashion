class BrandModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String logoUrl;
  final String coverImageUrl;

  BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.logoUrl,
    required this.coverImageUrl,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      logoUrl: json['logo']?['url']?.toString() ?? '',
      coverImageUrl: json['coverImage']?['url']?.toString() ?? '',
    );
  }
}