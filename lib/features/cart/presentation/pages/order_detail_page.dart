import 'package:cw_fashion/features/cart/presentation/bloc/cart_provider.dart';
import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../my_orders/presentation/bloc/review_provider.dart';
import '../../../my_orders/presentation/pages/review_bottom_sheet.dart';
import '../../../my_orders/presentation/pages/review_detail_bottom_sheet.dart';
import '../../data/models/order_response.dart';
import '../widgets/order_address_section.dart';
import '../widgets/order_detail_summary_section.dart';
import '../widgets/order_product_card.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<CartProvider>().getOrderDetail(widget.orderId);

      await context.read<ReviewProvider>().getMyReviews(widget.orderId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),

      body: Consumer2<CartProvider, ReviewProvider>(
        builder: (_, cartProvider, reviewProvider, __) {
          if (cartProvider.orderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final order = cartProvider.orderDetail;
          final item = order?.items.first;

          final reviewed = reviewProvider.isReviewed(item!.id);

          if (order == null) {
            return const Center(child: Text("Order not found"));
          }

          return SafeArea(
            child: Column(
              children: [
                const CustomHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Order Details",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Times New Roman",
                          ),
                        ),

                        const SizedBox(height: 25),

                        Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order #${order.orderNumber}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Text(
                                          "Placed on ${order.placedDate}",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: cartProvider
                                          .getOrderStatusColor(order.status)
                                          .withOpacity(.15),
                                    ),
                                    child: Text(
                                      order.status.toUpperCase(),
                                      style: TextStyle(
                                        color: cartProvider.getOrderStatusColor(
                                          order.status,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              /*SizedBox(
                                height: 48,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    /// invoice later
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(),
                                  ),
                                  icon: const Icon(
                                    Icons.receipt_long,
                                    color: Colors.black,
                                  ),
                                  label: const Text(
                                    "Download Invoice",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "Products",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),

                        const SizedBox(height: 15),

                        ...order.items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: OrderProductCard(item: item),
                          ),
                        ),

                        const SizedBox(height: 18),

                        OrderAddressSection(
                          title: "Shipping Address",
                          address: order.shippingAddress,
                        ),

                        const SizedBox(height: 18),

                        OrderDetailSummarySection(
                          subtotal: order.subtotal,
                          shipping: order.shippingCharge,
                          discount: order.discount,
                          total: order.total,
                        ),

                        const SizedBox(height: 18),

                        Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Icon(Icons.payments),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.payment.method.toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      order.payment.status.toUpperCase(),
                                      style: TextStyle(
                                        color: cartProvider.getPaymentStatusColor(
                                          order.payment.status,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        if (order.status.toLowerCase() == "pending") ...[
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Cancel Order API
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text(
                                "CANCEL ORDER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomePage(),
                                  ),
                                      (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text(
                                "RETURN HOME",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ]

                        else if (order.status.toLowerCase() == "delivered") ...[
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {

                                    if (reviewed) {

                                      final review = reviewProvider.getReview(item.id);

                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        builder: (_) {
                                          return ReviewDetailBottomSheet(
                                            review: review!,
                                          );
                                        },
                                      );

                                    } else {

                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.white,
                                        builder: (_) {
                                          return ChangeNotifierProvider.value(
                                            value: context.read<ReviewProvider>(),
                                            child: ReviewBottomSheet(
                                              productName: item.name,
                                              productId: item.product,
                                              vendorId: item.vendor,
                                              orderId: order.id,
                                              orderItemId: item.id,
                                            ),
                                          );
                                        },
                                      );

                                    }

                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    side: const BorderSide(color: Colors.black),
                                    shape: const RoundedRectangleBorder(),
                                  ),
                                  child: Text(
                                    reviewed ? "View Review" : "Write Review",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    // Request Return API
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    side: const BorderSide(color: Colors.deepOrange),
                                    shape: const RoundedRectangleBorder(),
                                  ),
                                  child: const Text(
                                    "Request Return",
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          if (order.items.first.isReturnable)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                "Returnable until ${DateTime.parse(order.createdAt).add(const Duration(days: 7)).day}/${DateTime.parse(order.createdAt).add(const Duration(days: 7)).month}/${DateTime.parse(order.createdAt).add(const Duration(days: 7)).year}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomePage(),
                                  ),
                                      (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text(
                                "RETURN HOME",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ]

                        else ...[
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomePage(),
                                    ),
                                        (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: const RoundedRectangleBorder(),
                                ),
                                child: const Text(
                                  "RETURN HOME",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
