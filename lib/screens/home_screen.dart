import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickcartai/screens/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration: const Duration(seconds: 2),

      lowerBound: 0.9,
      upperBound: 1.05,

    )..repeat(reverse: true);
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

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

          // GLOW EFFECTS
          Positioned(

            top: -100,
            left: -80,

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

            bottom: -120,
            right: -100,

            child: Container(

              width: 260,
              height: 260,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.14),
              ),
            ),
          ),

          SafeArea(

            child: SingleChildScrollView(

              physics: const BouncingScrollPhysics(),

              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,

              padding: EdgeInsets.only(

                left: 20,
                right: 20,
                top: 20,

                bottom:
                MediaQuery.of(context)
                    .viewInsets
                    .bottom + 30,
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // TOP BAR
                 
Wrap(

  alignment: WrapAlignment.spaceBetween,

  crossAxisAlignment:
  WrapCrossAlignment.center,

  runSpacing: 15,

  children: [

    Column(

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(

          "Hello, Jyoti 👋",

          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(

          "Welcome to QuickCart AI",

          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
      ],
    ),

    Row(

      mainAxisSize: MainAxisSize.min,

      children: [

        const SizedBox(width: 42),

        // NOTIFICATION
        Container(

          padding:
          const EdgeInsets.all(12),

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(18),

            color:
            Colors.white.withOpacity(0.08),

            border: Border.all(
              color:
              Colors.white.withOpacity(0.1),
            ),
          ),
        
          child: const Icon(
            Icons.notifications_none,
            color: Colors.white,
          ),
        ),

        
      ],
    ),
  ],
),


                  const SizedBox(height: 30),

                  // HERO CARD
                  ClipRRect(

                    borderRadius:
                    BorderRadius.circular(35),

                    child: BackdropFilter(

                      filter: ImageFilter.blur(
                        sigmaX: 8,
                        sigmaY: 8,
                      ),

                      child: Container(

                        width: double.infinity,

                        padding:
                        const EdgeInsets.all(28),

                        decoration: BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(35),

                          gradient: LinearGradient(

                            colors: [

                              Colors.blueAccent
                                  .withOpacity(0.25),

                              Colors.purpleAccent
                                  .withOpacity(0.2),
                            ],
                          ),

                          border: Border.all(
                            color:
                            Colors.white.withOpacity(0.1),
                          ),
                        ),

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(

                              "Ready to Shop?",

                              style:
                              GoogleFonts.poppins(

                                color: Colors.white,

                                fontSize: 30,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(

                              "Scan products and skip billing queues.",

                              style: GoogleFonts.inter(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 30),

                            Align(

                              alignment:
                              Alignment.centerRight,

                              child: Container(

                                padding:
                                const EdgeInsets.all(18),

                                decoration: BoxDecoration(

                                  shape: BoxShape.circle,

                                  color:
                                  Colors.white.withOpacity(0.08),
                                ),

                                child: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // SCAN BUTTON
                  Center(

                    child: ScaleTransition(

                      scale: controller,

                      child: GestureDetector(

                       onTap: () { Navigator.push( context, PageRouteBuilder( transitionDuration: const Duration(milliseconds: 500), pageBuilder: (_, animation, secondaryAnimation) { return const ScannerScreen(); }, transitionsBuilder: (_, animation, secondaryAnimation, child) { return FadeTransition( opacity: animation, child: SlideTransition( position: Tween<Offset>( begin: const Offset(0, 0.1), end: Offset.zero, ).animate(animation), child: child, ), ); }, ), ); },
                        child: Container(

                          width: 180,
                          height: 180,

                          decoration: BoxDecoration(

                            shape: BoxShape.circle,

                            gradient: const LinearGradient(

                              colors: [
                                Color(0xff4F8CFF),
                                Color(0xff7B61FF),
                              ],
                            ),

                            boxShadow: [

                              BoxShadow(
                                color:
                                Colors.blueAccent
                                    .withOpacity(0.45),

                                blurRadius: 25,
                                spreadRadius: 1,
                              ),
                            ],
                          ),

                          child: Center(
                            

                            child: Column(

                              mainAxisAlignment:
                              MainAxisAlignment.center,

                              children: [

                                const Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.white,
                                  size: 55,
                                ),

                                const SizedBox(height: 12),

                                Text(

                                  "Scan Product",

                                  style:
                                  GoogleFonts.poppins(

                                    color: Colors.white,

                                    fontSize: 18,

                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 45),

                  // RECENT ITEMS
                  sectionTitle("Recent Scanned"),

                  const SizedBox(height: 16),

                  SizedBox(

                    height: 120,

                    child: ListView.builder(

                      scrollDirection: Axis.horizontal,

                      itemCount: 4,

                      itemBuilder: (context, index) {

                        return glassCard(
                          title: "Product ${index + 1}",
                          subtitle: "₹199",
                          icon: Icons.shopping_bag_outlined,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 35),

                  // CATEGORIES
                  sectionTitle("Categories"),

                  const SizedBox(height: 16),

                  Wrap(

                    spacing: 14,
                    runSpacing: 14,

                    children: [

                      categoryCard(
                        "Groceries",
                        Icons.local_grocery_store,
                      ),

                      categoryCard(
                        "Electronics",
                        Icons.devices,
                      ),

                      categoryCard(
                        "Fashion",
                        Icons.checkroom,
                      ),

                      categoryCard(
                        "Snacks",
                        Icons.fastfood,
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // OFFERS
                  sectionTitle("Personalized Offers"),

                  const SizedBox(height: 16),

                  glassOfferCard(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {

    return Text(

      title,

      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget glassCard({

    required String title,
    required String subtitle,
    required IconData icon,

  }) {

    return Container(

      width: 160,

      margin: const EdgeInsets.only(right: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(28),

        color: Colors.white.withOpacity(0.08),

        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 34,
          ),

          const Spacer(),

          Text(

            title,

            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          Text(

            subtitle,

            style: GoogleFonts.inter(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryCard(
      String title,
      IconData icon,
      ) {

    return Container(

      width: 150,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(24),

        color: Colors.white.withOpacity(0.07),

        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),

      child: Column(

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 38,
          ),

          const SizedBox(height: 12),

          Text(

            title,

            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget glassOfferCard() {

    return ClipRRect(

      borderRadius: BorderRadius.circular(30),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),

        child: Container(

          width: double.infinity,

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(30),

            gradient: LinearGradient(

              colors: [

                Colors.purpleAccent
                    .withOpacity(0.2),

                Colors.blueAccent
                    .withOpacity(0.2),
              ],
            ),

            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),

          child: Row(

            children: [

              const Icon(
                Icons.local_offer_outlined,
                color: Colors.white,
                size: 45,
              ),

              const SizedBox(width: 18),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(

                      "20% OFF Premium Offer",

                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(

                      "Exclusive AI recommendation discount for today.",

                      style: GoogleFonts.inter(
                        color: Colors.white70,
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
    );
  }
}

