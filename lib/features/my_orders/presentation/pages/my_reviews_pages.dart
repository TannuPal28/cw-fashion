import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:cw_fashion/features/my_orders/presentation/bloc/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/my_review_card.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ReviewProvider>().getAllReviews();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<ReviewProvider>().loadMoreReviews();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),

      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(),

            Expanded(
              child: Consumer<ReviewProvider>(
                builder: (_, provider, __) {

                  if (provider.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (provider.reviews.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Reviews",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await provider.getAllReviews();
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          const Text(
                            "My Reviews",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Times New Roman",
                            ),
                          ),

                          const SizedBox(height: 25),

                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,

                              itemCount:
                              provider.reviews.length +
                                  (provider.loadMoreLoading
                                      ? 1
                                      : 0),

                              itemBuilder: (_, index) {

                                if (index ==
                                    provider.reviews.length) {
                                  return const Padding(
                                    padding:
                                    EdgeInsets.all(20),
                                    child: Center(
                                      child:
                                      CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                final review =
                                provider.reviews[index];

                                return Padding(
                                  padding:
                                  const EdgeInsets.only(
                                    bottom: 18,
                                  ),
                                  child: MyReviewCard(
                                    review: review,
                                  ),
                                );
                              },
                            ),
                          ),

                          if (!provider.hasMore)
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 10,
                              ),
                              child: Center(
                                child: Text(
                                  "All reviews loaded",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}