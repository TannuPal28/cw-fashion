import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CATEGORIES",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 25),

                    _item("Women", 3),
                    _item("Men", 3),
                    _item("Accessories", 2),
                    _item("Footwear", 1),
                    _item("Kids", 1),

                    const SizedBox(height: 40),

                    const Text(
                      "BRANDS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 25),

                    _item("Levi's", 2),
                    _item("Puma", 2),
                    _item("Nike", 1),
                    _item("Adidas", 1),
                    _item("H&M", 1),
                    _item("Zara", 1),
                    _item("HRX", 1),

                    const SizedBox(height: 40),

                    const Text(
                      "PRICE RANGE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Min",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Max",
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
