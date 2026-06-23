import 'package:cw_fashion/core/network/api_constants.dart';
import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/all_products/data/models/product_detail_model.dart';
import 'package:dio/dio.dart';

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
}
