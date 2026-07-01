import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/cart_provider.dart';

class AddAddressBottomSheet extends StatefulWidget {
  const AddAddressBottomSheet({super.key});

  @override
  State<AddAddressBottomSheet> createState() =>
      _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState
    extends State<AddAddressBottomSheet> {

  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final altPhoneController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();

  String label = "Home";

  bool isDefault = false;

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    altPhoneController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  InputDecoration decoration(String text) {
    return InputDecoration(
      labelText: text,
      border: const OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(

      initialChildSize: .92,
      minChildSize: .60,
      maxChildSize: .95,

      builder: (_, controller) {

        return Container(

          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),

          child: Form(

            key: _formKey,

            child: ListView(

              controller: controller,

              padding: const EdgeInsets.all(24),

              children: [

                Row(

                  children: [

                    const Expanded(

                      child: Text(
                        "Add Address",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: fullNameController,
                  decoration: decoration("Full Name *"),
                  validator: (v) =>
                  v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: decoration("Phone *"),
                  validator: (v) =>
                  v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: altPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: decoration("Alt. Phone"),
                ),

                const SizedBox(height: 18),

                DropdownButtonFormField<String>(

                  value: label,

                  decoration: decoration("Label"),

                  items: const [

                    DropdownMenuItem(
                      value: "Home",
                      child: Text("Home"),
                    ),

                    DropdownMenuItem(
                      value: "Office",
                      child: Text("Office"),
                    ),

                    DropdownMenuItem(
                      value: "Other",
                      child: Text("Other"),
                    ),

                  ],

                  onChanged: (v) {
                    setState(() {
                      label = v!;
                    });
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: address1Controller,
                  decoration: decoration("Address Line 1 *"),
                  validator: (v) =>
                  v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: address2Controller,
                  decoration: decoration("Address Line 2"),
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: landmarkController,
                  decoration: decoration("Landmark"),
                ),

                const SizedBox(height: 18),

                Row(

                  children: [

                    Expanded(
                      child: TextFormField(
                        controller: cityController,
                        decoration: decoration("City *"),
                        validator: (v) =>
                        v!.isEmpty ? "Required" : null,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: TextFormField(
                        controller: stateController,
                        decoration: decoration("State *"),
                        validator: (v) =>
                        v!.isEmpty ? "Required" : null,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: decoration("Pincode *"),
                  validator: (v) =>
                  v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 18),

                CheckboxListTile(

                  value: isDefault,

                  contentPadding: EdgeInsets.zero,

                  title: const Text(
                    "Set as default",
                    style: TextStyle(fontSize: 20),
                  ),

                  onChanged: (v) {
                    setState(() {
                      isDefault = v!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                Consumer<CartProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(),
                        ),
                        onPressed: provider.addAddressLoading
                            ? null
                            : () async {
                          if (!_formKey.currentState!.validate()) return;

                          final success = await provider.addAddress(
                            fullName: fullNameController.text.trim(),
                            phone: phoneController.text.trim(),
                            alternatePhone: altPhoneController.text.trim(),
                            addressLine1: address1Controller.text.trim(),
                            addressLine2: address2Controller.text.trim(),
                            landmark: landmarkController.text.trim(),
                            city: cityController.text.trim(),
                            state: stateController.text.trim(),
                            pincode: pincodeController.text.trim(),
                            label: label,
                            isDefault: isDefault,
                          );

                          if (!mounted) return;

                          if (success) {
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Address added successfully"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Failed to add address"),
                              ),
                            );
                          }
                        },
                        child: provider.addAddressLoading
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "SAVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                SizedBox(

                  height: 52,

                  child: OutlinedButton(

                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                    ),

                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}