import 'package:cw_fashion/features/all_products/data/datasources/search_remote_datasource.dart';
import 'package:cw_fashion/features/all_products/data/models/search_response_model.dart';

class SearchRepository {
  final SearchRemoteDatasource searchRemoteDatasource;

  SearchRepository(this.searchRemoteDatasource);

  Future<SearchResponseModel> search({
    required int page,
    required int limit,
    required String query,
    String? sort
  }) async {
    return await searchRemoteDatasource.search(
      page: page,
      limit: limit,
      query: query,
      sort: sort
    );
  }
}
