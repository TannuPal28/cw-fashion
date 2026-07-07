import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../cart/presentation/pages/order_detail_page.dart';
import '../bloc/my_orders_provier.dart';
import '../widgets/order_card.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final List<String> tabs = [
    "all",
    "pending",
    "accepted",
    "packed",
    "shipped",
    "out_for_delivery",
    "delivered",
    "cancelled",
  ];

  final Map<String, String> labels = {
    "all": "All",
    "pending": "Pending",
    "accepted": "Accepted",
    "packed": "Packed",
    "shipped": "Shipped",
    "out_for_delivery": "Out for delivery",
    "delivered": "Delivered",
    "cancelled": "Cancelled",
  };

  String selectedTab = "all";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderProvider>().getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: SafeArea(
        child: Consumer<OrderProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                const CustomHeader(),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await provider.getOrders(
                        status:
                        selectedTab == "all" ? null : selectedTab,
                      );
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "My Orders",
                              style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),

                            const SizedBox(height: 20),

                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Continue Shopping",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            SizedBox(
                              height: 48,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: tabs.length,
                                separatorBuilder:
                                    (_, __) =>
                                const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  final status = tabs[index];

                                  final selected =
                                      status == selectedTab;

                                  return InkWell(
                                    borderRadius:
                                    BorderRadius.circular(30),
                                    onTap: () async {
                                      setState(() {
                                        selectedTab = status;
                                      });

                                      await provider.getOrders(
                                        status: status == "all"
                                            ? null
                                            : status,
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                      const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(
                                          30,
                                        ),
                                        border: Border.all(
                                          color: Colors.grey
                                              .shade300,
                                        ),
                                      ),
                                      alignment:
                                      Alignment.center,
                                      child: Text(
                                        labels[status]!,
                                        style: TextStyle(
                                          color: selected
                                              ? Colors.white
                                              : const Color(
                                            0xff4b5563,
                                          ),
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 22),

                            if (provider.loading)
                              const Center(
                                child:
                                CircularProgressIndicator(),
                              )

                            else if ((provider.orderList?.orders ?? []).isEmpty)
                              SizedBox(
                                height: 400,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 80,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "No Orders Found",
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            else
                              ListView.separated(
                                itemCount: provider.orderList?.orders.length ?? 0,
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (_, __) =>
                                const SizedBox(height: 18),
                                itemBuilder:
                                    (context, index) {
                                  final order = provider.orderList!.orders[index];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              OrderDetailPage(
                                                orderId:
                                                order.id,
                                              ),
                                        ),
                                      );
                                    },
                                    child: OrderCard(
                                      order: order,
                                    ),
                                  );
                                },
                              ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}