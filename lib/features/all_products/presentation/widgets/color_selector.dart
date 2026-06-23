import 'package:flutter/material.dart';
import '../../data/models/product_detail_model.dart';

class ColorSelector extends StatefulWidget {
  final ProductData product;
  final Function(String) onColorSelected;

  const ColorSelector({
    super.key,
    required this.product,
    required this.onColorSelected,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late List<String> colors;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    colors = widget.product.variants
        .map((e) => e.color)
        .toSet()
        .toList();

    if (colors.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onColorSelected(colors.first);
      });
    }
  }

  Color getColor(String color) {
    switch (color.toLowerCase()) {
      case "black":
        return Colors.black;

      case "white":
        return Colors.white;

      case "red":
        return Colors.red;

      case "blue":
        return Colors.blue;

      case "green":
        return Colors.green;

      case "yellow":
        return Colors.amber;

      case "pink":
        return Colors.pink;

      case "grey":
        return Colors.grey;

      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Color: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "Select",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: List.generate(colors.length, (index) {

              final selected = index == selectedIndex;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });

                  widget.onColorSelected(colors[index]);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? Colors.black
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: getColor(colors[index]),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }
}