import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:cw_fashion/features/profile/presentation/bloc/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/auth_manager.dart';
import '../../../home/presentation/pages/home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final dobController = TextEditingController();
  String gender = "Female";
  DateTime? selectedDob;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Times New Roman",
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 28),
                          _title("Full Name"),
                          const SizedBox(height: 10),
                          _textField(controller: nameController),
                          const SizedBox(height: 20),

                          _title("Email"),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xfff5f5f5),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),

                          _title("Phone"),
                          const SizedBox(height: 10),
                          _textField(controller: phoneController),
                          const SizedBox(height: 20),

                          _title("Gender"),
                          const SizedBox(height: 10),

                          Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: gender,
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(
                                    value: "Male",
                                    child: Text("Male"),
                                  ),

                                  DropdownMenuItem(
                                    value: "Female",
                                    child: Text("Female"),
                                  ),

                                  DropdownMenuItem(
                                    value: "Other",
                                    child: Text("Other"),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          _title("Date of Birth"),
                          const SizedBox(height: 10),
                          TextField(
                            controller: dobController,
                            readOnly: true,

                            decoration: InputDecoration(
                              hintText: "dd/mm/yyyy",
                              suffixIcon: const Icon(
                                Icons.calendar_today_outlined,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                initialDate: selectedDob ?? DateTime.now(),
                              );

                              if (date == null) return;

                              selectedDob = date;

                              dobController.text = DateFormat(
                                "dd/MM/yyyy",
                              ).format(date);
                            },
                          ),
                          const SizedBox(height: 20),

                          Consumer<ProfileProvider>(
                            builder: (context, provider, child) {
                              return SizedBox(
                                width: 140,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: const RoundedRectangleBorder(),
                                  ),
                                  onPressed: provider.updateLoading
                                      ? null
                                      : () async {
                                          if (nameController.text
                                              .trim()
                                              .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text("Enter Name"),
                                              ),
                                            );
                                            return;
                                          }

                                          if (phoneController.text
                                              .trim()
                                              .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text("Enter Phone"),
                                              ),
                                            );
                                            return;
                                          }

                                          if (selectedDob == null) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Select Date of Birth",
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          final success = await context
                                              .read<ProfileProvider>()
                                              .updateProfile(
                                                name: nameController.text
                                                    .trim(),
                                                phone: phoneController.text
                                                    .toString(),
                                                gender: gender,
                                                dob: selectedDob!,
                                              );
                                          if (!mounted) return;

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                success
                                                    ? "Profile Updated Successfully"
                                                    : "Failed to Update Profile",
                                              ),
                                            ),
                                          );
                                        },
                                  child: provider.updateLoading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          "SAVE CHANGES",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 20),
                          Divider(color: Colors.grey.shade300),
                          const SizedBox(height: 28),

                          const Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 22),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: const Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _title("Current Password"),

                                const SizedBox(height: 10),

                                _passwordField(
                                  controller: currentPasswordController,
                                ),

                                const SizedBox(height: 24),

                                _title("New Password"),

                                const SizedBox(height: 10),
                                _passwordField(
                                  controller: newPasswordController,
                                ),

                                const SizedBox(height: 24),

                                _title("Confirm New Password"),

                                const SizedBox(height: 10),

                                _passwordField(
                                  controller: confirmPasswordController,
                                ),

                                const SizedBox(height: 28),

                                Consumer<ProfileProvider>(
                                  builder: (context, provider, child) {
                                    return SizedBox(
                                      width: 190,
                                      height: 52,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: const RoundedRectangleBorder(),
                                        ),
                                        onPressed: provider.passwordLoading
                                            ? null
                                            : () async {
                                                if (currentPasswordController
                                                        .text
                                                        .isEmpty ||
                                                    newPasswordController
                                                        .text
                                                        .isEmpty ||
                                                    confirmPasswordController
                                                        .text
                                                        .isEmpty) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Please fill all fields",
                                                      ),
                                                    ),
                                                  );
                                                  return;
                                                }

                                                if (newPasswordController
                                                        .text !=
                                                    confirmPasswordController
                                                        .text) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Passwords do not match",
                                                      ),
                                                    ),
                                                  );
                                                  return;
                                                }

                                                final success = await context
                                                    .read<ProfileProvider>()
                                                    .updatePassword(
                                                      currentPassword:
                                                          currentPasswordController
                                                              .text
                                                              .trim(),
                                                      newPassword:
                                                          newPasswordController
                                                              .text
                                                              .trim(),
                                                    );

                                                if (!mounted) return;

                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      success
                                                          ? "Password Updated Successfully"
                                                          : "Failed to Update Password",
                                                    ),
                                                  ),
                                                );

                                                if (success) {
                                                  currentPasswordController
                                                      .clear();
                                                  newPasswordController.clear();
                                                  confirmPasswordController
                                                      .clear();
                                                }
                                              },
                                        child: provider.passwordLoading
                                            ? const SizedBox(
                                                width: 22,
                                                height: 22,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                              )
                                            : const Text(
                                                "UPDATE PASSWORD",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 1,
                                                  fontSize: 16,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          Divider(color: Colors.grey.shade300),

                          const SizedBox(height: 30),

                          Consumer<ProfileProvider>(
                            builder: (context, provider, child) {
                              return SizedBox(
                                width: 150,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: const RoundedRectangleBorder(),
                                  ),
                                  onPressed: provider.logoutLoading
                                      ? null
                                      : () async {
                                          final success = await context
                                              .read<ProfileProvider>()
                                              .logout();

                                          if (!mounted) return;

                                          if (success) {
                                            // Local data clear
                                            await AuthManager.clearToken();

                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const HomePage(),
                                              ),
                                              (route) => false,
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text("Logout Failed"),
                                              ),
                                            );
                                          }
                                        },
                                  child: provider.logoutLoading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          "LOGOUT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xff374151),
      ),
    );
  }

  Widget _textField({required TextEditingController controller}) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }

  Widget _passwordField({required TextEditingController controller}) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}
