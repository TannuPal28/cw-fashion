import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../home/presentation/widgets/custom_header.dart';
import '../bloc/cart_provider.dart';
import '../widgets/checkout_order_summary.dart';
import '../widgets/delivery_address_section.dart';
import '../widgets/payment_method_Section.dart';
import 'address_list_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String paymentMethod = "cod";

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = context.read<CartProvider>();

      await Future.wait([provider.getCart(), provider.getAddresses()]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),

      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  /// Custom Header
                  const CustomHeader(),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        /// Delivery Address
                        if (provider.addressLoading)
                          Container(
                            height: 120,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          )
                        else
                          DeliveryAddressSection(
                            hasAddress: provider.selectedAddress != null,
                            address: provider.selectedAddress,

                            onAddAddress: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddressListPage(),
                                ),
                              );
                            },
                            onChangeAddress: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddressListPage(),
                                ),
                              );

                            },
                          ),

                        const SizedBox(height: 16),

                        /// Payment Method
                        PaymentMethodSection(
                          selectedMethod: paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        /// Order Summary
                        CheckoutOrderSummary(
                          items: provider.items,
                          subtotal:
                              provider.shippingInfo?.subtotal.toDouble() ?? 0,
                          shipping:
                              provider.shippingInfo?.charge.toDouble() ?? 0,
                          total: provider.shippingInfo?.total.toDouble() ?? 0,
                          onPlaceOrder: () {
                            // TODO: Place Order API
                          },
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
