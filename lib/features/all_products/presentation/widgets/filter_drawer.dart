import 'package:cw_fashion/features/all_products/presentation/bloc/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late TextEditingController minController;
  late TextEditingController maxController;

  String? selectedCategory;
  String? selectedBrand;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final provider = context.read<SearchProvider>();
    selectedCategory = provider.selectedCategory;
    selectedBrand = provider.selectedBrand;

    minController = TextEditingController(text: provider.minPrice ?? "");
    maxController = TextEditingController(text: provider.maxPrice ?? "");
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .63,
          height: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Filters",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Categories",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),

                            ...provider.filters!.categories.map((e) {
                              return RadioListTile<String>(
                                value: e.id ?? "",
                                groupValue: selectedCategory,
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text("${e.name} (${e.count})"),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                },
                              );
                            }),
                            const SizedBox(height: 25),

                            const Text(
                              "Brands",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 10),

                            ...provider.filters!.brands.map((e) {
                              return RadioListTile<String>(
                                value: e.id ?? "",
                                groupValue: selectedBrand,
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text("${e.name} (${e.count})"),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBrand = value;
                                  });
                                },
                              );
                            }),

                            const SizedBox(height: 25),

                            const Text(
                              "Price",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: minController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "Min Price",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: TextField(
                                    controller: maxController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "Max Price",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                provider.clearFilters();

                                minController.clear();
                                maxController.clear();

                                Navigator.pop(context);

                                await provider.search(provider.currentQuery);
                              },
                              child: const Text("Clear"),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                provider.selectedCategory = selectedCategory;
                                provider.selectedBrand = selectedBrand;

                                provider.minPrice = minController.text.trim();
                                provider.maxPrice = maxController.text.trim();

                                Navigator.pop(context);

                                await provider.search(
                                  provider.currentQuery,
                                  sort: provider.currentSort,
                                  category: provider.selectedCategory,
                                  brand: provider.selectedBrand,
                                  minPrice: provider.minPrice,
                                  maxPrice: provider.maxPrice,
                                );
                              },
                              child: const Text("Apply"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(String title, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Text("$title ($count)", style: const TextStyle(fontSize: 18)),
    );
  }
}
