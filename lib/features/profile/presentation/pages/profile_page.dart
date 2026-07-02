import 'package:cw_fashion/features/home/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController(text: "Tannu Pal");
  final emailController = TextEditingController(text: "tannupal510@gmail.com");
  final phoneController = TextEditingController(text: "9999999999");

  final dobController = TextEditingController();
  String gender = "Female";

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
                          _textField(controller: emailController),
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
                                initialDate: DateTime.now(),
                              );
                              if (date == null) return;
                              dobController.text =
                                  "${date.day}/${date.month}/${date.year}";
                            },
                          ),
                          const SizedBox(height: 20),

                          SizedBox(
                            width: 140,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "SAVE CHANGES",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
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

                                _passwordField(),

                                const SizedBox(height: 24),

                                _title("New Password"),

                                const SizedBox(height: 10),

                                _passwordField(),

                                const SizedBox(height: 24),

                                _title("Confirm New Password"),

                                const SizedBox(height: 10),

                                _passwordField(),

                                const SizedBox(height: 28),

                                SizedBox(
                                  width: 190,
                                  height: 52,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder(),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "UPDATE PASSWORD",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          Divider(color: Colors.grey.shade300),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: 150,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: const RoundedRectangleBorder(),
                              ),
                              onPressed: () {
                                // Logout API
                              },
                              child: const Text(
                                "LOGOUT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
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

  Widget _passwordField() {
    return SizedBox(
      height: 56,
      child: TextField(
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
