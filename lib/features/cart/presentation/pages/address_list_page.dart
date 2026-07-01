import 'package:cw_fashion/features/cart/presentation/bloc/cart_provider.dart';
import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_address_bottom_sheet.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CartProvider>().getAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Consumer<CartProvider>(
        builder: (_, provider, __) {
          if (provider.addressLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const CustomHeader(),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Addresses",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Times New Roman",
                        ),
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(),
                          ),
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => const AddAddressBottomSheet(),
                            );

                            context.read<CartProvider>().getAddresses();
                          },
                          child: const Text(
                            "+ ADD ADDRESS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      if (provider.addresses.isEmpty)
                        SizedBox(
                          height: 450,
                          child: Center(
                            child: Text(
                              "No addresses saved",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.addresses.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 18),
                          itemBuilder: (_, index) {
                            final address = provider.addresses[index];

                            return GestureDetector(
                              onTap: () {
                                provider.selectAddress(address);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        provider.selectedAddress?.id ==
                                            address.id
                                        ? Colors.black
                                        : Colors.grey.shade300,
                                    width:
                                        provider.selectedAddress?.id ==
                                            address.id
                                        ? 2
                                        : 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            address.fullName,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        Radio<String>(
                                          value: address.id,
                                          groupValue:
                                              provider.selectedAddress?.id,
                                          activeColor: Colors.black,
                                          onChanged: (_) {
                                            provider.selectAddress(address);
                                            Navigator.pop(context);
                                          },
                                        ),

                                        if (address.isDefault)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            color: Colors.black,
                                            child: const Text(
                                              "DEFAULT",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),

                                        const SizedBox(width: 10),

                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          color: Colors.grey.shade200,
                                          child: Text(
                                            address.addressType.toUpperCase(),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    Text(
                                      "${address.addressLine1}, ${address.addressLine2}",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 18,
                                      ),
                                    ),

                                    Text(
                                      "${address.city}, ${address.state} - ${address.pincode}",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 18,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      address.phone,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 18,
                                      ),
                                    ),

                                    const SizedBox(height: 22),

                                    Row(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            /// Edit Address
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Colors.black,
                                            ),
                                            shape:
                                                const RoundedRectangleBorder(),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 18),

                                        OutlinedButton(
                                          onPressed: () {
                                            /// Delete Address
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Colors.red,
                                            ),
                                            shape:
                                                const RoundedRectangleBorder(),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
