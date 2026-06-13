import 'package:flutter/material.dart';
import 'product_card.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF9ECEC),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          const Text(
            "FLASH SALE",
            style: TextStyle(
              color: Colors.red,
              letterSpacing: 4,
                fontWeight: FontWeight.bold
            ),
          ),

          const Text(
            "Limited Time Offers",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [

              _timer("340","Hrs"),
              _timer("43","Min"),
              _timer("39","Sec"),

              const Spacer(),

              const Text(
                "View All →",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              )
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: const [

              Expanded(
                child: ProductCard(
                  title: "Men Jeans",
                  price: "₹500",
                  oldPrice: "₹1,100",
                  sold: "24+ sold",
                  image:
                  "https://picsum.photos/400/600",
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: ProductCard(
                  title: "Women Top",
                  price: "₹900",
                  oldPrice: "",
                  sold: "15+ sold",
                  image:
                  "https://picsum.photos/401/600",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _timer(
      String value,
      String label,
      ) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius:
        BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
              FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}