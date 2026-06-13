import 'package:cw_fashion/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';

class TrendingSection extends StatelessWidget {
  final String title;
  const TrendingSection({super.key,  required this.title,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12,),
          Container(
            width: 90,
            height: 4,
            color: const Color(0xffC8A648),
          ),

          const SizedBox(height: 5),

          const Text(
            "View All",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            children: const [

              Expanded(
                child: ProductCard(
                  image:
                  "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f",
                  title: "Men Jeans",
                  price: "₹500",
                  oldPrice: "₹1,100",
                  sold: "24+ sold",
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: ProductCard(
                  image:
                  "https://images.unsplash.com/photo-1529139574466-a303027c1d8b",
                  title: "Women Top",
                  price: "₹900",
                  oldPrice: "",
                  sold: "15+ sold",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
