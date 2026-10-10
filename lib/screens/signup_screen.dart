import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/mobile_auth_service.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeTerms = false;

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff020617),
                  Color(0xff071A3D),
                  Color(0xff0A2472),
                ],
              ),
            ),
          ),

          // GLOW EFFECTS
          Positioned(
            top: -80,
            left: -60,

            child: Container(
              width: 220,
              height: 220,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.18),
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            right: -80,

            child: Container(
              width: 260,
              height: 260,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.15),
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
            builder: (context, constraints) {

            return SingleChildScrollView(

            physics: const BouncingScrollPhysics(), keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,


            child: ConstrainedBox(
            constraints: BoxConstraints(
            minHeight: constraints.maxHeight, 
            ),

            child: IntrinsicHeight(

              child: Padding(

              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [

                  const SizedBox(height: 20),

                  // LOGO
                  Container(

                    width: 100,
                    height: 100,

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(28),

                      color: Colors.white.withOpacity(0.08),

                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.5),
                          blurRadius: 35,
                          spreadRadius: 5,
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.shopping_cart_checkout_rounded,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "QuickCart AI",

                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // GLASS CARD
                  ClipRRect(

                    borderRadius: BorderRadius.circular(35),

                    child: BackdropFilter(

                      filter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),

                      child: Container(

                        padding: const EdgeInsets.all(28),

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(35),

                          color: Colors.white.withOpacity(0.08),

                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Create Your Account",

                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "Start your smart retail shopping experience.",

                              style: GoogleFonts.inter(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 30),

                            // FULL NAME
                            buildTextField(
                              controller: nameController,
                              hint: "Full Name",
                              icon: Icons.person_outline,
                            ),

                            const SizedBox(height: 18),

                            // EMAIL
                            buildTextField(
                              controller: emailController,
                              hint: "Email Address",
                              icon: Icons.email_outlined,
                            ),

                            const SizedBox(height: 18),

                            // PHONE
                            buildTextField(
                              controller: phoneController,
                              hint: "Phone Number",
                              icon: Icons.phone_outlined,
                            ),

                            const SizedBox(height: 18),

                            // PASSWORD
                            buildPasswordField(),

                            const SizedBox(height: 18),

                            // CONFIRM PASSWORD
                            buildConfirmPasswordField(),

                            const SizedBox(height: 18),

                            // TERMS
                            Row(

                              children: [

                                Checkbox(
                                  value: agreeTerms,

                                  onChanged: (value) {

                                    setState(() {
                                      agreeTerms = value!;
                                    });
                                  },
                                ),

                                Expanded(

                                  child: Text(
                                    "I agree to Terms & Conditions",

                                    style: GoogleFonts.inter(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),

                            // CREATE ACCOUNT BUTTON
                            Container(

                              width: double.infinity,
                              height: 60,

                              decoration: BoxDecoration(

                                borderRadius:
                                BorderRadius.circular(20),

                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff4F8CFF),
                                    Color(0xff7B61FF),
                                  ],
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.blueAccent.withOpacity(0.5),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),

                              child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),

                                
onPressed: () async {

  // PASSWORD CHECK
  if (passwordController.text !=
      confirmPasswordController.text) {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Passwords do not match"),
      ),
    );

    return;
  }

  // TERMS CHECK
  if (!agreeTerms) {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text(
          "Please accept Terms & Conditions",
        ),
      ),
    );

    return;
  }

  final response =
  await MobileAuthService.signup(

    name: nameController.text,
    email: emailController.text,
    phone: phoneController.text,
    password: passwordController.text,
  );

  if (response["status"] == 200) {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Signup Successful"),
      ),
    );

    Navigator.pop(context);

  } else {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(response["body"]),
      ),
    );
  }
},



                                child: Text(
                                  "Create Account",

                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // GOOGLE SIGNUP
                            OutlinedButton.icon(

                              style: OutlinedButton.styleFrom(

                                minimumSize:
                                const Size(double.infinity, 58),

                                side: BorderSide(
                                  color:
                                  Colors.white.withOpacity(0.15),
                                ),

                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                              ),

                              onPressed: () {},

                              icon: const Icon(
                                Icons.g_mobiledata,
                              ),

                              label: const Text(
                                "Continue with Google",
                              ),
                            ),

                            const SizedBox(height: 28),

                            // LOGIN
                            Center(

                              child: GestureDetector(

                                onTap: () {
                                  Navigator.pop(context);
                                },

                                child: RichText(

                                  text: TextSpan(

                                    children: [

                                      const TextSpan(
                                        text:
                                        "Already have an account? ",

                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),

                                      TextSpan(
                                        text: "Login",

                                        style:
                                        GoogleFonts.poppins(
                                          color:
                                          const Color(0xff7FB2FF),

                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
            );
            },
      ),
    ),
        ],
      ),
    );
  }

  Widget buildTextField({

    required TextEditingController controller,
    required String hint,
    required IconData icon,

  }) {

    return TextField(

      controller: controller,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle:
        const TextStyle(color: Colors.white54),

        prefixIcon:
        Icon(icon, color: Colors.white70),

        filled: true,

        fillColor: Colors.white.withOpacity(0.05),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildPasswordField() {

    return TextField(

      controller: passwordController,

      obscureText: obscurePassword,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(

        hintText: "Password",

        hintStyle:
        const TextStyle(color: Colors.white54),

        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.white70,
        ),

        suffixIcon: IconButton(

          icon: Icon(
            obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,

            color: Colors.white70,
          ),

          onPressed: () {

            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
        ),

        filled: true,

        fillColor: Colors.white.withOpacity(0.05),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildConfirmPasswordField() {

    return TextField(

      controller: confirmPasswordController,

      obscureText: obscureConfirmPassword,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(

        hintText: "Confirm Password",

        hintStyle:
        const TextStyle(color: Colors.white54),

        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.white70,
        ),

        suffixIcon: IconButton(

          icon: Icon(
            obscureConfirmPassword
                ? Icons.visibility_off
                : Icons.visibility,

            color: Colors.white70,
          ),

          onPressed: () {

            setState(() {
              obscureConfirmPassword =
              !obscureConfirmPassword;
            });
          },
        ),

        filled: true,

        fillColor: Colors.white.withOpacity(0.05),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

