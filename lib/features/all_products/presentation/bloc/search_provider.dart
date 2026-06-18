import 'package:cw_fashion/features/all_products/data/models/search_response_model.dart';
import 'package:cw_fashion/features/all_products/data/repositories/search_repository.dart';
import 'package:flutter/widgets.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepository searchRepository;

  SearchProvider(this.searchRepository);

  List<ProductModel> products = [];
  FiltersModel? filters;
  PaginationModel? pagination;

  bool isLoading = false;
  bool isLoadMore = false;
  bool hasError = false;

  int currentPage = 1;
  int totalPages = 1;
  final int limit = 20;
  String currentQuery = "";
  String? currentSort;

  Future<void> search(String query, {String? sort}) async {
    currentQuery = query;
    if (sort != null) {
      currentSort = sort;
    }

    currentSort = sort;
    currentPage = 1;
    totalPages = 1;
    products.clear();

    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final response = await searchRepository.search(
        page: currentPage,
        limit: limit,
        query: query,
        sort: currentSort
      );
      products = response.products;
      filters = response.filters;
      pagination = response.pagination;

      totalPages = response.pagination.totalPages;
    } catch (e) {
      hasError = true;
      debugPrint("Search error : $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isLoadMore) return;
    if (currentPage >= totalPages) return;
    isLoadMore = true;
    notifyListeners();

    try {
      currentPage++;
      final response = await searchRepository.search(
        page: currentPage,
        limit: limit,
        query: currentQuery,
        sort: currentSort
      );
      products.addAll(response.products);

      filters = response.filters;
      pagination = response.pagination;

      totalPages = response.pagination.totalPages;
    } catch (e) {
      currentPage--;

      debugPrint("Load More Error : $e");
    }
    isLoadMore = false;
    notifyListeners();
  }

  //pull to refresh
  Future<void> refresh() async {
    await search(currentQuery,sort: currentSort);
  }

  /// Clear Search
  void clearSearch() {
    products.clear();

    filters = null;
    pagination = null;

    currentPage = 1;
    totalPages = 1;
    currentQuery = "";

    isLoading = false;
    isLoadMore = false;
    hasError = false;

    notifyListeners();
  }

  /// Has Next Page
  bool get hasNextPage => currentPage < totalPages;

  /// Total Products
  int get totalProducts => pagination?.total ?? 0;

  /// Is Empty
  bool get isEmpty => !isLoading && products.isEmpty;
}
