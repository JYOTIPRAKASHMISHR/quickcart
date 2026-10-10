import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quickcartai/models/product_model.dart';
import 'package:quickcartai/screens/product_details_screen.dart';
import 'package:quickcartai/services/product_service.dart';


class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() =>
      _ScannerScreenState();
}

class _ScannerScreenState
    extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {

      final MobileScannerController scannerController =
MobileScannerController();


  late AnimationController controller;

  late Animation<double> animation;

  bool flashOn = false;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    animation = Tween<double>(
      begin: -220,
      end: 220,
    ).animate(

      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomInset: true,

      backgroundColor: const Color(0xff020617),

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

          // TOP GLOW
          Positioned(

            top: -120,
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

          // BOTTOM GLOW
          Positioned(

            bottom: -150,
            right: -120,

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

          SafeArea(

            child: SingleChildScrollView(

              physics:
              const BouncingScrollPhysics(),

              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior
                  .onDrag,

              padding: const EdgeInsets.all(20),

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  // TOP BAR
                  Row(

                    children: [

                      scannerButton(
                        Icons.arrow_back_ios_new,
                            () {
                          Navigator.pop(context);
                        },
                      ),

                      const Spacer(),

                      Text(

                        "QuickCart",

                        style:
                        GoogleFonts.poppins(

                          color: Colors.white,

                          fontSize: 24,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      scannerButton(
                        flashOn
                            ? Icons.flash_on
                            : Icons.flash_off,

                            () {

                          setState(() {
                            flashOn = !flashOn;
                          });
                          scannerController.toggleTorch();
                        },
                      ),

                      const SizedBox(width: 12),

                      scannerButton(
                        Icons.help_outline,
                            () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // AI TAG
                  glassTag(),

                  const SizedBox(height: 40),

                  
Center(

  child: Stack(

    alignment: Alignment.center,

    children: [

      // CAMERA
      ClipRRect(

        borderRadius:
        BorderRadius.circular(35),

        child: SizedBox(

          width: 320,
          height: 420,

          child: MobileScanner(

            controller: scannerController,

            onDetect: (capture) async {

              final List<Barcode> barcodes =
              capture.barcodes;

              for (final barcode in barcodes) {

                final String? code =
                    barcode.rawValue;

                if (code != null) {

                 
final product =
await ProductService
    .getProduct(code);

if (product != null) {

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) =>
          ProductDetailsScreen(
            product: product,
          ),
    ),
  );
}


                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    SnackBar(
                      content:
                      Text("Scanned: $code"),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),

      // DARK OVERLAY
      Container(

        width: 320,
        height: 420,

        decoration: BoxDecoration(

          borderRadius:
          BorderRadius.circular(35),

          border: Border.all(
            color:
            Colors.blueAccent
                .withOpacity(0.25),
          ),
        ),
      ),

      // GLOW CORNERS
      ...scannerCorners(),

      // SCAN LINE
      AnimatedBuilder(

        animation: animation,

        builder:
            (context, child) {

          return Positioned(

            top:
            210 + animation.value,

            child: Container(

              width: 260,
              height: 3,

              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(20),

                gradient:
                const LinearGradient(

                  colors: [

                    Colors.transparent,

                    Color(0xff4F8CFF),

                    Colors.white,

                    Color(0xff4F8CFF),

                    Colors.transparent,
                  ],
                ),

                boxShadow: [

                  BoxShadow(
                    color:
                    Colors.blueAccent
                        .withOpacity(0.8),

                    blurRadius: 20,
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

                  const SizedBox(height: 40),

                  // TEXT
                  Text(

                    "Align barcode inside the frame",

                    textAlign: TextAlign.center,

                    style: GoogleFonts.inter(

                      color: Colors.white70,

                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // SCAN BUTTON
                  GestureDetector(

                    onTap: () {

                      // OPEN CAMERA SCANNER
                    },

                    child: Container(

                      width: 100,
                      height: 100,

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,

                        gradient:
                        const LinearGradient(

                          colors: [

                            Color(0xff4F8CFF),
                            Color(0xff7B61FF),
                          ],
                        ),

                        boxShadow: [

                          BoxShadow(
                            color:
                            Colors.blueAccent
                                .withOpacity(0.5),

                            blurRadius: 25,
                            spreadRadius: 1,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.barcode_reader,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),

                  const SizedBox(height: 45),

                  // AI TIP CARD
                  ClipRRect(

                    borderRadius:
                    BorderRadius.circular(30),

                    child: BackdropFilter(

                      filter: ImageFilter.blur(
                        sigmaX: 8,
                        sigmaY: 8,
                      ),

                      child: Container(

                        width: double.infinity,

                        padding:
                        const EdgeInsets.all(22),

                        decoration: BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(30),

                          color:
                          Colors.white
                              .withOpacity(0.06),

                          border: Border.all(
                            color:
                            Colors.white
                                .withOpacity(0.08),
                          ),
                        ),

                        child: Row(

                          children: [

                            Container(

                              width: 55,
                              height: 55,

                              decoration: BoxDecoration(

                                shape: BoxShape.circle,

                                color:
                                Colors.blueAccent
                                    .withOpacity(0.15),
                              ),

                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Text(

                                    "AI Tip",

                                    style:
                                    GoogleFonts.poppins(

                                      color: Colors.white,

                                      fontSize: 18,

                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(

                                    "Ensure proper lighting and hold device steady for accurate scanning.",

                                    style:
                                    GoogleFonts.inter(

                                      color:
                                      Colors.white70,

                                      height: 1.5,
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }

  Widget scannerButton(
      IconData icon,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        width: 52,
        height: 52,

        decoration: BoxDecoration(

          borderRadius:
          BorderRadius.circular(18),

          color:
          Colors.white.withOpacity(0.08),

          border: Border.all(
            color:
            Colors.white.withOpacity(0.08),
          ),
        ),

        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget glassTag() {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(30),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),

        child: Container(

          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 14,
          ),

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(30),

            color:
            Colors.white.withOpacity(0.06),

            border: Border.all(
              color:
              Colors.white.withOpacity(0.08),
            ),
          ),

          child: Row(

            mainAxisSize: MainAxisSize.min,

            children: [

              const Icon(
                Icons.auto_awesome,
                color: Color(0xff7FB2FF),
                size: 20,
              ),

              const SizedBox(width: 10),

              Text(

                "AI Powered Scanner",

                style:
                GoogleFonts.poppins(

                  color: Colors.white,

                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> scannerCorners() {

    return [

      // TOP LEFT
      Positioned(
        top: 0,
        left: 0,
        child: corner(),
      ),

      // TOP RIGHT
      Positioned(
        top: 0,
        right: 0,
        child: Transform.rotate(
          angle: 1.57,
          child: corner(),
        ),
      ),

      // BOTTOM LEFT
      Positioned(
        bottom: 0,
        left: 0,
        child: Transform.rotate(
          angle: -1.57,
          child: corner(),
        ),
      ),

      // BOTTOM RIGHT
      Positioned(
        bottom: 0,
        right: 0,
        child: Transform.rotate(
          angle: 3.14,
          child: corner(),
        ),
      ),
    ];
  }

  Widget corner() {

    return Container(

      width: 80,
      height: 80,

      decoration: const BoxDecoration(

        border: Border(

          top: BorderSide(
            color: Color(0xff4F8CFF),
            width: 6,
          ),

          left: BorderSide(
            color: Color(0xff4F8CFF),
            width: 6,
          ),
        ),
      ),
    );
  }
}

