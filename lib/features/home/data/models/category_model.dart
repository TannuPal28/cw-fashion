class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imageUrl: json['image']?['url']?.toString() ?? '',
    );
  }
}