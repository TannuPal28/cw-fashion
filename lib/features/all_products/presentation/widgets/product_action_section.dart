import 'package:flutter/material.dart';

class ProductActionSection extends StatefulWidget {
  const ProductActionSection({super.key});

  @override
  State<ProductActionSection> createState() =>
      _ProductActionSectionState();
}

class _ProductActionSectionState
    extends State<ProductActionSection> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [

          /// Quantity
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [

                InkWell(
                  onTap: () {
                    if (qty > 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  child: Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  child: Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      qty++;
                    });
                  },
                  child: Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          /// Add To Cart
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text(
                  "ADD TO CART",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          /// Wishlist
          Container(
            width: 40,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: const Icon(
              Icons.favorite_border,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}