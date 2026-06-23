import 'package:cw_fashion/features/all_products/data/datasources/product_detail_remote_datasource.dart';
import 'package:cw_fashion/features/all_products/data/models/product_detail_model.dart';

class ProductDetailRepository {
  final ProductDetailRemoteDatasource productDetailRemoteDatasource;
  ProductDetailRepository(this.productDetailRemoteDatasource);

  Future<ProductDetailResponse> productDetail(String productId){
    return productDetailRemoteDatasource.productDetail(productId);
  }
}