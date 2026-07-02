import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../home/presentation/widgets/custom_header.dart';
import '../bloc/cart_provider.dart';
import '../widgets/checkout_order_summary.dart';
import '../widgets/delivery_address_section.dart';
import '../widgets/payment_method_Section.dart';
import 'address_list_page.dart';
import 'order_detail_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String paymentMethod = "cod";
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      _handlePaymentSuccess,
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      _handlePaymentError,
    );

    _razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
      _handleExternalWallet,
    );

    Future.microtask(() async {
      final provider = context.read<CartProvider>();

      await Future.wait([
        provider.getCart(),
        provider.getAddresses(),
      ]);
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(
      PaymentSuccessResponse response) {

    print(response.paymentId);
    print(response.orderId);
    print(response.signature);

  }

  void _handlePaymentError(
      PaymentFailureResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(response.message ?? "Payment Failed"),
      ),

    );

  }

  void _handleExternalWallet(
      ExternalWalletResponse response) {

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
                          onPlaceOrder: () async {

                            if (paymentMethod != "cod") {
                              return;
                            }

                            final provider = context.read<CartProvider>();

                            final order = await provider.placeOrder("cod");

                            if (!mounted) return;

                            if (order != null) {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OrderDetailPage(
                                    orderId: order.id,
                                  ),
                                ),
                              );
                            }
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
