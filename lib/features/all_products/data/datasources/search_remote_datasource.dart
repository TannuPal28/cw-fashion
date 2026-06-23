import 'package:cw_fashion/core/network/api_constants.dart';
import 'package:cw_fashion/core/network/dio_client.dart';
import 'package:cw_fashion/features/all_products/data/models/search_response_model.dart';
import 'package:dio/dio.dart';

class SearchRemoteDatasource {
  final DioClient dioClient;

  SearchRemoteDatasource(this.dioClient);

  Future<SearchResponseModel> search({
    required int page,
    required int limit,
    required String query,
    String? sort,
    String? category,
    String? brand,
    String? minPrice,
    String? maxPrice,
  }) async {
    final Map<String, dynamic> params = {"page": page, "limit": limit};
    if (query.isNotEmpty) {
      params["q"] = query;
    }
    if (sort != null && sort.isNotEmpty) {
      params["sort"] = sort;
    }
    if (category != null && category.isNotEmpty) {
      params["category"] = category;
    }
    if (brand != null && brand.isNotEmpty) {
      params["brand"] = brand;
    }
    if (minPrice != null && minPrice.isNotEmpty) {
      params["minPrice"] = minPrice;
    }
    if (maxPrice != null && maxPrice.isNotEmpty) {
      params["maxPrice"] = maxPrice;
    }
    final response = await dioClient.get(
      ApiConstants.search,
      queryParameters: params,
    );
    return SearchResponseModel.fromJson(response.data);
  }
}
