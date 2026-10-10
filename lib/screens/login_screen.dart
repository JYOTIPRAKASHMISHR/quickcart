
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signup_screen.dart';

import '../services/mobile_auth_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool obscurePassword = true;
  bool rememberMe = false;

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomInset: true,

      body: Container(

        width: double.infinity,

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

        child: SafeArea(

          child: SingleChildScrollView(

            physics: const BouncingScrollPhysics(),

            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, padding: EdgeInsets.only( left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24, ),

            // padding: const EdgeInsets.all(24),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                const SizedBox(height: 40),

                // LOGO
                Container(

                  width: 110,
                  height: 110,

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(30),

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
                    size: 60,
                  ),
                ),

                const SizedBox(height: 20),

                // APP NAME
                Text(

                  "QuickCart AI",

                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 50),

                // GLASS CARD
                ClipRRect(

                  borderRadius: BorderRadius.circular(35),

                  child: BackdropFilter(

                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),

                    child: Container(

                      width: double.infinity,

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

                          // HEADING
                          Text(

                            "Welcome Back",

                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // SUBTITLE
                          Text(

                            "Login to continue smart shopping experience.",

                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 35),

                          // EMAIL FIELD
                          buildTextField(
                            controller: emailController,
                            hint: "Email or Phone Number",
                            icon: Icons.email_outlined,
                          ),

                          const SizedBox(height: 20),

                          // PASSWORD FIELD
                          buildPasswordField(),

                          const SizedBox(height: 18),

                          // REMEMBER + FORGOT
                         
Wrap(

  alignment: WrapAlignment.spaceBetween,
  crossAxisAlignment: WrapCrossAlignment.center,

  children: [

    Row(

      mainAxisSize: MainAxisSize.min,

      children: [

        Checkbox(
          value: rememberMe,

          onChanged: (value) {

            setState(() {
              rememberMe = value!;
            });
          },
        ),

        const Text(

          "Remember Me",

          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    ),

    TextButton(

      onPressed: () {},

      child: const Text(

        "Forgot Password?",

        style: TextStyle(
          color: Color(0xff7FB2FF),
        ),
      ),
    ),
  ],
),


                          const SizedBox(height: 25),

                          // LOGIN BUTTON
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

  final response =
  await MobileAuthService.login(

    email: emailController.text,
    password: passwordController.text,
  );

  if (response["status"] == 200) {

    final token =
    response["body"]["accessToken"];

    // STORE JWT TOKEN
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      "token",
      token,
    );

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Login Successful"),
      ),
    );

    print(token);

    // GO TO HOME SCREEN
   
Navigator.pushReplacement(

  context,

  MaterialPageRoute(
    builder: (_) => const HomeScreen(),
  ),
);



  } else {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Login Failed"),
      ),
    );
  }
},


                              child: Text(

                                "Login",

                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // GOOGLE BUTTON
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

                          // SIGNUP
                          Center(

                            child: GestureDetector(

                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                    const SignupScreen(),
                                  ),
                                );
                              },

                              child: RichText(

                                text: TextSpan(

                                  children: [

                                    const TextSpan(

                                      text:
                                      "Don’t have an account? ",

                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),

                                    TextSpan(

                                      text: "Sign Up",

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

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
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

      style: const TextStyle(
        color: Colors.white,
      ),

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

      style: const TextStyle(
        color: Colors.white,
      ),

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
}

