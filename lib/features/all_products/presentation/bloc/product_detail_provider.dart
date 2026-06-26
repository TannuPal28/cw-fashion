import 'dart:math';

import 'package:cw_fashion/features/all_products/data/models/product_detail_model.dart';
import 'package:cw_fashion/features/all_products/data/repositories/product_detail_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/product_review_model.dart';
import '../../data/models/related_product_response_model.dart';

class ProductDetailProvider extends ChangeNotifier {
  final ProductDetailRepository repository;

  ProductDetailProvider(this.repository);

  bool isLoading = false;
  ProductData? product;
  ProductVariant? selectedVariant;
  int selectedImageIndex = 0;

  List<RelatedProduct> relatedProducts = [];
  bool relatedLoading = false;

  List<ProductReviewModel> reviews = [];
  bool reviewLoading = false;

  String selectedColor = "";
  String selectedSize = "";
  int quantity = 1;

  String? error;

  Future<void> getProductDetail(String productId) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await repository.productDetail(productId);
      product = response.product;

      if (product != null && product!.variants.isNotEmpty) {
        selectedVariant = product!.variants.first;
        selectedColor = selectedVariant!.color;
        selectedSize = selectedVariant!.size;
      }
    } catch (e) {
      error = e.toString();
      debugPrint(error);
    }

    isLoading = false;
    notifyListeners();
  }

  void changeImage(int index) {
    selectedImageIndex = index;
    notifyListeners();
  }

  void increaseQty() {
    quantity++;
    notifyListeners();
  }

  void decreaseQty() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  List<String> get colors {
    if (product == null) return [];
    return product!.variants.map((e) => e.color).toSet().toList();
  }

  List<String> get sizes {
    if (product == null) return [];

    return product!.variants
        .where((e) => e.color == selectedColor)
        .map((e) => e.size)
        .toSet()
        .toList();
  }

  void selectColor(String color) {
    selectedColor = color;

    final variant = product!.variants.firstWhere(
      (e) => e.color == color,
      orElse: () => product!.variants.first,
    );

    selectedVariant = variant;
    selectedSize = variant.size;

    selectedImageIndex = 0;

    notifyListeners();
  }

  void selectSize(String size) {
    selectedSize = size;

    selectedVariant = product!.variants.firstWhere(
      (e) => e.color == selectedColor && e.size == size,
      orElse: () => product!.variants.first,
    );

    selectedImageIndex = 0;

    notifyListeners();
  }

  List<String> get images {
    if (selectedVariant != null && selectedVariant!.images.isNotEmpty) {
      return selectedVariant!.images.map((e) => e.url).toList();
    }

    return product?.images.map((e) => e.url).toList() ?? [];
  }

  String get currentImage {
    if (images.isEmpty) return "";

    return images[selectedImageIndex];
  }

  int get price {
    return selectedVariant?.price ?? product?.minPrice ?? 0;
  }

  int get mrp {
    return selectedVariant?.mrp ?? product?.mrp ?? 0;
  }

  int get discountPercent {
    if (mrp == 0) return 0;

    return (((mrp - price) / mrp) * 100).round();
  }

  int get stock {
    return selectedVariant?.availableStock ?? 0;
  }

  double get rating {
    return product?.rating ?? 0;
  }

  int get totalReviews {
    return product?.numRatings ?? 0;
  }

  String get title {
    return product?.title ?? "";
  }

  String get description {
    return product?.description ?? "";
  }

  Future<void> getRelatedProducts(String productId) async {
    try {
      relatedLoading = true;
      notifyListeners();

      relatedProducts =
      await repository.getRelatedProducts(productId);

    } catch (e) {
      debugPrint(e.toString());
    } finally {
      relatedLoading = false;
      notifyListeners();
    }
  }

  Future<void> getReviews(
      String productId,
      ) async {
    try {
      reviewLoading = true;
      notifyListeners();

      reviews =
      await repository.getReviews(productId);

    } catch (e) {
      debugPrint(e.toString());
    } finally {
      reviewLoading = false;
      notifyListeners();
    }
  }

  bool isWishlisted = false;
  bool wishlistLoading = false;

  final Set<String> wishlistedProducts = {};
  bool isProductWishlisted(String productId) {
    return wishlistedProducts.contains(productId);
  }

  Future<void> toggleWishlist(String productId) async {
    try {
      if (wishlistedProducts.contains(productId)) {
        await repository.removeFromWishlist(productId);
        wishlistedProducts.remove(productId);
      } else {
        await repository.addToWishlist(productId);
        wishlistedProducts.add(productId);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      wishlistLoading = false;
      notifyListeners();
    }
  }

}
