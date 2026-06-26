import 'package:cw_fashion/features/all_products/data/datasources/product_detail_remote_datasource.dart';
import 'package:cw_fashion/features/all_products/data/models/product_detail_model.dart';

import '../models/product_review_model.dart';
import '../models/related_product_response_model.dart';

class ProductDetailRepository {
  final ProductDetailRemoteDatasource productDetailRemoteDatasource;
  ProductDetailRepository(this.productDetailRemoteDatasource);

  Future<ProductDetailResponse> productDetail(String productId){
    return productDetailRemoteDatasource.productDetail(productId);
  }
  Future<List<RelatedProduct>> getRelatedProducts(String productId) {
    return productDetailRemoteDatasource.getRelatedProducts(productId);
  }
  Future<List<ProductReviewModel>> getReviews(
      String productId,
      ) {
    return productDetailRemoteDatasource
        .getReviews(productId);
  }

  Future<List<String>> addToWishlist(String productId) {
    return productDetailRemoteDatasource.addToWishlist(productId);
  }

  Future<List<String>> removeFromWishlist(String productId) {
    return productDetailRemoteDatasource.removeFromWishlist(productId);
  }
}