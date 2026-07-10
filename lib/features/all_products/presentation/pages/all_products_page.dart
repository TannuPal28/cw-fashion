import 'package:cw_fashion/features/all_products/presentation/pages/product_detail_page.dart';
import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../home/presentation/widgets/product_card.dart';
import '../bloc/search_provider.dart';
import '../widgets/filter_drawer.dart';

class AllProductsPage extends StatefulWidget {
  final String query;

  const AllProductsPage({super.key, required this.query});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  late ScrollController _scrollController;
  String selectedSort = "Sort by: Newest";
  final Map<String, String> sortMap = {
    "Sort by: Newest": "newest",
    "Price: Low to High": "price_asc",
    "Price: High to Low": "price_desc",
    "Top Rated": "rating_desc",
    "Best Selling": "best_selling",
  };
  late final Map<String, String> reverseSortMap;

  @override
  void initState() {
    super.initState();
    reverseSortMap = {
      for (var e in sortMap.entries) e.value: e.key,
    };

    _scrollController = ScrollController();

    Future.microtask(() {
      context.read<SearchProvider>().search(widget.query);
    });

    _scrollController.addListener(_pagination);
  }

  void _pagination() {
    final provider = context.read<SearchProvider>();

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      provider.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Consumer<SearchProvider>(
          builder: (_, provider, __) {
            if (provider.currentSort != null) {
              selectedSort =
                  reverseSortMap[provider.currentSort] ?? "Sort by: Newest";
            }
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.isEmpty) {
              return const Center(child: Text("No Products Found"));
            }

            return RefreshIndicator(
              onRefresh: provider.refresh,
              child: SingleChildScrollView(
                controller: _scrollController,

                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const CustomHeader(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          _title(provider),

                          _sort(),

                          const SizedBox(height: 15),

                          _products(provider),

                          if (provider.isLoadMore)
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _title(SearchProvider provider) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

          child: InkWell(
            onTap: () {
              _openFilterDrawer();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.tune, size: 20),
                  SizedBox(width: 10),
                  Text("Filters"),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              const Flexible(
                child: Text(
                  "All Products",

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              const SizedBox(width: 5),

              Text(
                "(${provider.totalProducts})",

                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sort() {
    return Consumer<SearchProvider>(
      builder: (_, provider, __) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xffdddddd)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedSort,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: sortMap.keys.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) async {
                if (value == null) return;

                setState(() {
                  selectedSort = value;
                });

                await provider.search(
                  widget.query,
                  sort: sortMap[value],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _products(SearchProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
        childAspectRatio: .47,
      ),
      itemBuilder: (_, index) {
        final product = provider.products[index];

        int discount = 0;

        if (product.mrp > 0) {
          discount = (((product.mrp - product.flashSalePrice) / product.mrp) * 100)
              .round();
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(
                  productId: product.id,
                ),
              ),
            );
          },
          child: ProductCard(
            image: product.images.isNotEmpty
                ? product.images.first.url
                : "",
            title: product.title,
            price: "₹${product.flashSalePrice}",
            oldPrice: "₹${product.mrp}",
            rating: product.rating,
            reviews: product.numRatings,
            sold: "${product.totalSold}+ sold",
            discount: "-$discount%",
          ),
        );
      },
    );
  }
  void _openFilterDrawer() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return const FilterDrawer();
      },
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
