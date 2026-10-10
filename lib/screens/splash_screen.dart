
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:quickcartai/screens/home_screen.dart'; 
import 'package:quickcartai/screens/login_screen.dart';

void main() {
  runApp(const QuickCartAI());
}

class QuickCartAI extends StatelessWidget {
  const QuickCartAI({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark(),

      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {

    super.initState();

    _controller = AnimationController(

      vsync: this,

      duration: const Duration(seconds: 2),

    )..repeat();

    checkLogin();
  }

  // AUTO LOGIN CHECK
  Future<void> checkLogin() async {

    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString("token");

    // SPLASH DELAY
    await Future.delayed(
      const Duration(seconds: 4),
    );

    // TOKEN EXISTS
    if (token != null && token.isNotEmpty) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );

    } else {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }

  Widget particle(
      double top,
      double left,
      double size,
      ) {

    return Positioned(

      top: top,
      left: left,

      child: Container(

        width: size,
        height: size,

        decoration: BoxDecoration(

          shape: BoxShape.circle,

          color: Colors.white.withOpacity(0.7),

          boxShadow: [

            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.8),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screen =
    MediaQuery.of(context).size;

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

          // GLOW TOP
          Positioned(

            top: -100,
            left: -80,

            child: Container(

              width: 260,
              height: 260,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.blue
                    .withOpacity(0.18),
              ),
            ),
          ),

          // GLOW BOTTOM
          Positioned(

            bottom: -120,
            right: -100,

            child: Container(

              width: 320,
              height: 320,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.purple
                    .withOpacity(0.15),
              ),
            ),
          ),

          // PARTICLES
          ...List.generate(

            35,

                (index) => particle(

              Random().nextDouble()
                  * screen.height,

              Random().nextDouble()
                  * screen.width,

              Random().nextDouble() * 4 + 2,
            ),
          ),

          // MAIN CONTENT
          SafeArea(

            child: Column(

              children: [

                const Spacer(),

                // LOGO
                TweenAnimationBuilder(

                  tween:
                  Tween<double>(
                    begin: 0.8,
                    end: 1,
                  ),

                  duration:
                  const Duration(seconds: 2),

                  curve: Curves.easeOutBack,

                  builder:
                      (context, value, child) {

                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },

                  child: Container(

                    width: 170,
                    height: 170,

                    decoration: BoxDecoration(

                      borderRadius:
                      BorderRadius.circular(45),

                      gradient: LinearGradient(

                        colors: [

                          Colors.white
                              .withOpacity(0.18),

                          Colors.white
                              .withOpacity(0.04),
                        ],
                      ),

                      border: Border.all(
                        color:
                        Colors.white
                            .withOpacity(0.18),
                      ),

                      boxShadow: [

                        BoxShadow(
                          color:
                          Colors.blueAccent
                              .withOpacity(0.4),

                          blurRadius: 20,
                          spreadRadius: 1,
                        ),
                      ],
                    ),

                    child: ClipRRect(

                      borderRadius:
                      BorderRadius.circular(45),

                      child: BackdropFilter(

                        filter: ImageFilter.blur(
                          sigmaX: 8,
                          sigmaY: 8,
                        ),

                        child: const Center(

                          child: Icon(
                            Icons.shopping_cart_checkout_rounded,
                            size: 85,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                // APP NAME
                ShaderMask(

                  shaderCallback: (bounds) {

                    return const LinearGradient(

                      colors: [

                        Colors.white,
                        Color(0xff79AFFF),
                        Color(0xffA98BFF),
                      ],
                    ).createShader(bounds);
                  },

                  child: Text(

                    "QuickCart",

                    style: GoogleFonts.poppins(

                      color: Colors.white,

                      fontSize: 42,

                      fontWeight: FontWeight.w700,

                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // TAGLINE
                Text(

                  "Skip the Queue. Shop Smarter.",

                  textAlign: TextAlign.center,

                  style: GoogleFonts.inter(

                    color:
                    Colors.white.withOpacity(0.72),

                    fontSize: 16,

                    fontWeight: FontWeight.w400,
                  ),
                ),

                const Spacer(),

                // LOADING TEXT
                Text(

                  "Loading Experience...",

                  style: GoogleFonts.inter(

                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 20),

                // LOADER
                Padding(

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 45,
                  ),

                  child: AnimatedBuilder(

                    animation: _controller,

                    builder: (context, child) {

                      return ClipRRect(

                        borderRadius:
                        BorderRadius.circular(20),

                        child: LinearProgressIndicator(

                          value: _controller.value,

                          minHeight: 7,

                          backgroundColor:
                          Colors.white10,

                          valueColor:
                          const AlwaysStoppedAnimation(
                            Color(0xff73A5FF),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
