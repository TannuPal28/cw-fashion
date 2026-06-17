import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/product_card.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //filter or title
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.tune,size:20),
                              SizedBox(width:10),
                              Text("Filters"),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Row(
                            children: const [
                              Flexible(
                                child: Text(
                                  "All Products",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize:18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "(10 items)",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    //sort dropdown ui
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffdddddd)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sort by: Newest",
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    //products
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: demoProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 20,
                            childAspectRatio: .47,
                          ),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          image: demoProducts[index]["image"],
                          title: demoProducts[index]["title"],
                          price: demoProducts[index]["price"],
                          oldPrice: demoProducts[index]["oldPrice"],
                          rating: demoProducts[index]["rating"],
                          reviews: demoProducts[index]["reviews"],
                          sold: demoProducts[index]["sold"],
                          discount: demoProducts[index]["discount"],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> demoProducts = [
  {
    "image":
    "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f",
    "title": "Women's Yoga Top",
    "price": "₹1,499",
    "oldPrice": "₹2,499",
    "rating": 4.3,
    "reviews": 118,
    "sold": "276+ sold",
    "discount": "-40%",
  },
  {
    "image":
    "https://images.unsplash.com/photo-1523170335258-f5ed11844a49",
    "title": "Classic Analog Watch",
    "price": "₹2,999",
    "oldPrice": "₹5,299",
    "rating": 4.0,
    "reviews": 48,
    "sold": "134+ sold",
    "discount": "-43%",
  },
];
