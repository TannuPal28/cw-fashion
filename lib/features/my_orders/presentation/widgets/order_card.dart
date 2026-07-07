import 'package:flutter/material.dart';
import '../../data/models/order_list_model.dart';

class OrderCard extends StatelessWidget {
  final OrderItem order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final item = order.items.first;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Order No + Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${order.orderNumber}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff9CA3AF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      order.createdAt,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  _StatusChip(
                    text: order.status,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "₹${order.total.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 18),

          /// Product
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius:
                BorderRadius.circular(6),
                child: Image.network(
                  item.image,
                  height: 95,
                  width: 95,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      item.name,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Color: ${item.color}    Size: ${item.size}    Qty: ${item.quantity}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff6B7280),
                      ),
                    ),

                    const SizedBox(height: 12),

                    _StatusChip(
                      text: order.status,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Text(
                "₹${item.finalPrice}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 12),

         /* Row(
            children: [

              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 16,
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  order.shippingAddress.city,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff6B7280),
                  ),
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;

  const _StatusChip({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {

    Color bg = const Color(0xffFFF8E1);
    Color border = const Color(0xffF4C430);
    Color textColor = const Color(0xffC58A00);

    switch (text.toLowerCase()) {
      case "accepted":
        bg = const Color(0xffE8F5E9);
        border = Colors.green;
        textColor = Colors.green;
        break;

      case "packed":
        bg = const Color(0xffE3F2FD);
        border = Colors.blue;
        textColor = Colors.blue;
        break;

      case "shipped":
        bg = const Color(0xffEDE7F6);
        border = Colors.deepPurple;
        textColor = Colors.deepPurple;
        break;

      case "out_for_delivery":
        bg = const Color(0xffFFF3E0);
        border = Colors.orange;
        textColor = Colors.orange;
        break;

      case "delivered":
        bg = const Color(0xffE8F5E9);
        border = Colors.green;
        textColor = Colors.green;
        break;

      case "cancelled":
        bg = const Color(0xffFDECEC);
        border = Colors.red;
        textColor = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border),
      ),
      child: Text(
        text.replaceAll("_", " "),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }
}