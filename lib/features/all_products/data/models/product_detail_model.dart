class ProductDetailResponse {
  final bool success;
  final ProductData product;

  ProductDetailResponse({
    required this.success,
    required this.product,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      success: json["success"] ?? false,
      product: ProductData.fromJson(json["product"] ?? {}),
    );
  }
}

class ProductData {
  final String id;
  final String title;
  final String description;

  final Category category;
  final Brand brand;
  final Vendor vendor;

  final bool isActive;
  final bool isFeatured;
  final bool isNewArrival;
  final bool isReturnable;
  final bool isFlashSale;
  final bool isBestSeller;
  final bool isTrending;

  final int returnWindow;

  final List<String> tags;

  final List<ProductImage> images;
  final List<ProductVariant> variants;

  final double rating;
  final int numRatings;
  final int numReviews;

  final int totalSold;

  final int minPrice;
  final int maxPrice;
  final int mrp;

  final int totalStock;

  final int cartCount;
  final int wishlistCount;

  final List<ProductReview> reviews;

  ProductData({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.brand,
    required this.vendor,
    required this.isActive,
    required this.isFeatured,
    required this.isNewArrival,
    required this.isReturnable,
    required this.isFlashSale,
    required this.isBestSeller,
    required this.isTrending,
    required this.returnWindow,
    required this.tags,
    required this.images,
    required this.variants,
    required this.rating,
    required this.numRatings,
    required this.numReviews,
    required this.totalSold,
    required this.minPrice,
    required this.maxPrice,
    required this.mrp,
    required this.totalStock,
    required this.cartCount,
    required this.wishlistCount,
    required this.reviews,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",

      category: Category.fromJson(json["category"] ?? {}),
      brand: Brand.fromJson(json["brand"] ?? {}),
      vendor: Vendor.fromJson(json["vendor"] ?? {}),

      isActive: json["isActive"] ?? false,
      isFeatured: json["isFeatured"] ?? false,
      isNewArrival: json["isNewArrival"] ?? false,
      isReturnable: json["isReturnable"] ?? false,
      isFlashSale: json["isFlashSale"] ?? false,
      isBestSeller: json["isBestSeller"] ?? false,
      isTrending: json["isTrending"] ?? false,

      returnWindow: json["returnWindow"] ?? 0,

      tags: List<String>.from(json["tags"] ?? []),

      images: (json["images"] as List? ?? [])
          .map((e) => ProductImage.fromJson(e))
          .toList(),

      variants: (json["variants"] as List? ?? [])
          .map((e) => ProductVariant.fromJson(e))
          .toList(),

      rating: (json["rating"] ?? 0).toDouble(),
      numRatings: json["numRatings"] ?? 0,
      numReviews: json["numReviews"] ?? 0,

      totalSold: json["totalSold"] ?? 0,

      minPrice: json["minPrice"] ?? 0,
      maxPrice: json["maxPrice"] ?? 0,
      mrp: json["mrp"] ?? 0,

      totalStock: json["totalStock"] ?? 0,

      cartCount: json["cartCount"] ?? 0,
      wishlistCount: json["wishlistCount"] ?? 0,

      reviews: (json["reviews"] as List? ?? [])
          .map((e) => ProductReview.fromJson(e))
          .toList(),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
    );
  }
}

class Brand {
  final String id;
  final String name;
  final String slug;

  Brand({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
    );
  }
}

class Vendor {
  final String id;
  final String storeName;
  final String storeDescription;
  final double storeRating;
  final int totalRatings;

  Vendor({
    required this.id,
    required this.storeName,
    required this.storeDescription,
    required this.storeRating,
    required this.totalRatings,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json["_id"] ?? "",
      storeName: json["storeName"] ?? "",
      storeDescription: json["storeDescription"] ?? "",
      storeRating: (json["storeRating"] ?? 0).toDouble(),
      totalRatings: json["totalRatings"] ?? 0,
    );
  }
}

class ProductImage {
  final String url;
  final String publicId;
  final bool isPrimary;

  ProductImage({
    required this.url,
    required this.publicId,
    required this.isPrimary,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      url: json["url"] ?? "",
      publicId: json["publicId"] ?? "",
      isPrimary: json["isPrimary"] ?? false,
    );
  }
}

class ProductVariant {
  final String id;
  final String sku;
  final String color;
  final String size;

  final int price;
  final int mrp;

  final int stock;
  final int reservedStock;
  final int availableStock;

  final bool isActive;

  final List<VariantImage> images;

  ProductVariant({
    required this.id,
    required this.sku,
    required this.color,
    required this.size,
    required this.price,
    required this.mrp,
    required this.stock,
    required this.reservedStock,
    required this.availableStock,
    required this.isActive,
    required this.images,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json["_id"] ?? "",
      sku: json["sku"] ?? "",
      color: json["color"] ?? "",
      size: json["size"] ?? "",

      price: json["price"] ?? 0,
      mrp: json["mrp"] ?? 0,

      stock: json["stock"] ?? 0,
      reservedStock: json["reservedStock"] ?? 0,
      availableStock: json["availableStock"] ?? 0,

      isActive: json["isActive"] ?? false,

      images: (json["images"] as List? ?? [])
          .map((e) => VariantImage.fromJson(e))
          .toList(),
    );
  }
}

class VariantImage {
  final String url;
  final String publicId;

  VariantImage({
    required this.url,
    required this.publicId,
  });

  factory VariantImage.fromJson(Map<String, dynamic> json) {
    return VariantImage(
      url: json["url"] ?? "",
      publicId: json["publicId"] ?? "",
    );
  }
}

class ProductReview {
  final String id;

  ProductReview({
    required this.id,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json["_id"] ?? "",
    );
  }
}