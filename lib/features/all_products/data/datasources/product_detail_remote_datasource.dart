import 'package:cw_fashion/core/network/api_constants.dart';
import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/all_products/data/models/product_detail_model.dart';
import 'package:dio/dio.dart';

import '../models/product_review_model.dart';
import '../models/related_product_response_model.dart';

class ProductDetailRemoteDatasource {
  final DioClient dioClient;

  ProductDetailRemoteDatasource(this.dioClient);

  Future<ProductDetailResponse> productDetail(String productId) async {
    try {
      final response = await dioClient.get(
        "${ApiConstants.productDetail}/$productId",
      );

      return ProductDetailResponse.fromJson(response.data);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RelatedProduct>> getRelatedProducts(String productId) async {
    try {
      final response = await dioClient.get(
        "${ApiConstants.productDetail}/$productId/related",
      );

      return (response.data["products"] as List)
          .map((e) => RelatedProduct.fromJson(e))
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<ProductReviewModel>> getReviews(
      String productId,
      ) async {
    final response = await dioClient.get(
      "/products/$productId/reviews?sort=latest",
    );

    return (response.data["reviews"] as List)
        .map((e) => ProductReviewModel.fromJson(e))
        .toList();
  }

  Future<List<String>> addToWishlist(String productId) async {
    final response = await dioClient.post(
      "/users/wishlist/$productId",
    );

    return List<String>.from(response.data["wishlist"]);
  }

  Future<List<String>> removeFromWishlist(String productId) async {
    final response = await dioClient.delete(
      "/users/wishlist/$productId",
    );

    return List<String>.from(response.data["wishlist"]);
  }


}
