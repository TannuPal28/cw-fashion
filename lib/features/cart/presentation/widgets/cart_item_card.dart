import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String vendor;
  final String color;
  final String size;
  final int price;
  final int mrp;
  final int quantity;

  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemCard({
    super.key,
    required this.image,
    required this.title,
    required this.vendor,
    required this.color,
    required this.size,
    required this.price,
    required this.mrp,
    required this.quantity,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 105,
            height: 145,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Title
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),


                /// Vendor
                Text(
                  vendor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                /// Color + Size
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      color: Colors.grey.shade100,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.circle, size: 10),
                          const SizedBox(width: 5),
                          Text(color),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      color: Colors.grey.shade100,
                      child: Text("Size: $size"),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Price
                Row(
                  children: [

                    Text(
                      "₹$price",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "₹$mrp",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "Returnable 7d",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 13,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  children: [
                    offerChip("SECOND"),
                    offerChip("FIRST"),
                  ],
                ),

                const SizedBox(height: 15),

                /// Bottom Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        qtyButton("-", onDecrease),
                        qtyBox(quantity.toString()),
                        qtyButton("+", onIncrease),
                      ],
                    ),


                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text(
                            "₹$price",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          InkWell(
                            onTap: onRemove,
                            child: const Text(
                              "Remove",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget offerChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget qtyButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget qtyBox(String value) {
    return Container(
      width: 40,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}