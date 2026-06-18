class SearchResponseModel {
  final bool success;
  final List<ProductModel> products;
  final FiltersModel filters;
  final PaginationModel pagination;

  SearchResponseModel({
    required this.success,
    required this.products,
    required this.filters,
    required this.pagination,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      success: json["success"] ?? false,
      products: (json["products"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      filters: FiltersModel.fromJson(json["filters"] ?? {}),
      pagination: PaginationModel.fromJson(json["pagination"] ?? {}),
    );
  }
}

class FiltersModel {
  final List<FilterItemModel> categories;
  final List<FilterItemModel> brands;

  FiltersModel({required this.categories, required this.brands});

  factory FiltersModel.fromJson(Map<String, dynamic> json) {
    return FiltersModel(
      categories: (json["categories"] as List? ?? [])
          .map((e) => FilterItemModel.fromJson(e))
          .toList(),
      brands: (json["brands"] as List? ?? [])
          .map((e) => FilterItemModel.fromJson(e))
          .toList(),
    );
  }
}

class FilterItemModel {
  final String? id;
  final String? name;
  final String? slug;
  final int count;

  FilterItemModel({this.id, this.name, this.slug, required this.count});

  factory FilterItemModel.fromJson(Map<String, dynamic> json) {
    return FilterItemModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      count: json["count"] ?? 0,
    );
  }
}

class PaginationModel {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json["page"] ?? 1,
      limit: json["limit"] ?? 20,
      total: json["total"] ?? 0,
      totalPages: json["totalPages"] ?? 1,
    );
  }
}

class ProductModel {
  final String id;
  final String title;
  final String description;

  final CategoryModel category;
  final BrandModel brand;
  final VendorModel vendor;

  final bool isFlashSale;

  final int flashSalePrice;
  final int mrp;

  final double rating;
  final int numRatings;
  final int totalSold;

  final List<ImageModel> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.brand,
    required this.vendor,
    required this.isFlashSale,
    required this.flashSalePrice,
    required this.mrp,
    required this.rating,
    required this.numRatings,
    required this.totalSold,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      category: CategoryModel.fromJson(json["category"] ?? {}),
      brand: BrandModel.fromJson(json["brand"] ?? {}),
      vendor: VendorModel.fromJson(json["vendor"] ?? {}),
      isFlashSale: json["isFlashSale"] ?? false,
      flashSalePrice: json["flashSalePrice"] ?? 0,
      mrp: json["mrp"] ?? 0,
      rating: (json["rating"] ?? 0).toDouble(),
      numRatings: json["numRatings"] ?? 0,
      totalSold: json["totalSold"] ?? 0,
      images: (json["images"] as List? ?? [])
          .map((e) => ImageModel.fromJson(e))
          .toList(),
    );
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String slug;

  CategoryModel({required this.id, required this.name, required this.slug});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
    );
  }
}

class BrandModel {
  final String id;
  final String name;
  final String slug;

  BrandModel({required this.id, required this.name, required this.slug});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
    );
  }
}

class VendorModel {
  final String id;
  final String storeName;

  VendorModel({required this.id, required this.storeName});

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json["_id"] ?? "",
      storeName: json["storeName"] ?? "",
    );
  }
}

class ImageModel {
  final String url;
  final String publicId;
  final bool isPrimary;

  ImageModel({
    required this.url,
    required this.publicId,
    required this.isPrimary,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json["url"] ?? "",
      publicId: json["publicId"] ?? "",
      isPrimary: json["isPrimary"] ?? false,
    );
  }
}
