import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product_model.dart';

class ProductDetailsScreen
    extends StatefulWidget {

  final ProductModel product;

  const ProductDetailsScreen({

    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {

    final product = widget.product;

    return Scaffold(

      backgroundColor:
      const Color(0xff020617),

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

          SafeArea(

            child: SingleChildScrollView(

              physics:
              const BouncingScrollPhysics(),

              padding:
              const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // TOP
                  Row(

                    children: [

                      topButton(
                        Icons.arrow_back_ios_new,
                            () {
                          Navigator.pop(context);
                        },
                      ),

                      const Spacer(),

                      topButton(
                        Icons.favorite_border,
                            () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // PRODUCT IMAGE
                  Center(

                    child: Hero(

                      tag: product.id,

                      child: Container(

                        width: 280,
                        height: 280,

                        decoration: BoxDecoration(

                          borderRadius:
                          BorderRadius.circular(40),

                          color:
                          Colors.white
                              .withOpacity(0.08),
                        ),

                        child: ClipRRect(

                          borderRadius:
                          BorderRadius.circular(40),

                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // PRODUCT NAME
                  Text(

                    product.productName,

                    style:
                    GoogleFonts.poppins(

                      color: Colors.white,

                      fontSize: 32,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(

                    product.category,

                    style:
                    GoogleFonts.inter(

                      color: Colors.white70,

                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // INFO CARD
                  glassCard(

                    child: Row(

                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        infoItem(
                          "Barcode",
                          product.barcodeNumber,
                        ),

                        infoItem(
                          "Stock",
                          "${product.quantity}",
                        ),

                        // infoItem(
                        //   "Rating",
                        //   "${product.rating}",
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // PRICE CARD
                  glassCard(

                    child: Row(

                      children: [

                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(

                              "₹${product.sellingPrice}",

                              style:
                              GoogleFonts.poppins(

                                color: Colors.white,

                                fontSize: 32,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(

                              "MRP ₹${product.mrpPrice}",

                              style:
                              GoogleFonts.inter(

                                color:
                                Colors.white54,

                                decoration:
                                TextDecoration
                                    .lineThrough,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        Container(

                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),

                          decoration: BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(
                                20),

                            color: Colors.green
                                .withOpacity(0.2),
                          ),

                          child: Text(

                            "${(((product.mrpPrice -
                                product.sellingPrice) /
                                product.mrpPrice) *
                                100).toInt()}% OFF",

                            style:
                            GoogleFonts.poppins(

                              color: Colors.greenAccent,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // QUANTITY
                  glassCard(

                    child: Row(

                      children: [

                        Text(

                          "Quantity",

                          style:
                          GoogleFonts.poppins(

                            color: Colors.white,

                            fontSize: 18,

                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),

                        const Spacer(),

                        quantityButton(
                          Icons.remove,
                              () {

                            if (quantity > 1) {

                              setState(() {
                                quantity--;
                              });
                            }
                          },
                        ),

                        Padding(

                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 20),

                          child: Text(

                            quantity.toString(),

                            style:
                            GoogleFonts.poppins(

                              color: Colors.white,

                              fontSize: 22,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                        quantityButton(
                          Icons.add,
                              () {

                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // BUTTONS
                  Row(

                    children: [

                      Expanded(

                        child: actionButton(
                          "Add to Cart",
                          Colors.white12,
                              () {},
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(

                        child: actionButton(
                          "Buy Now",
                          const Color(0xff4F8CFF),
                              () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // DESCRIPTION
                  Text(

                    "Description",

                    style:
                    GoogleFonts.poppins(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    product.description,

                    style:
                    GoogleFonts.inter(

                      color: Colors.white70,

                      height: 1.8,

                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // RELATED
                  Text(

                    "Related Products",

                    style:
                    GoogleFonts.poppins(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(

                    height: 160,

                    child: ListView.builder(

                      scrollDirection:
                      Axis.horizontal,

                      itemCount: 4,

                      itemBuilder:
                          (context, index) {

                        return Container(

                          width: 140,

                          margin:
                          const EdgeInsets.only(
                              right: 16),

                          decoration: BoxDecoration(

                            borderRadius:
                            BorderRadius.circular(
                                30),

                            color:
                            Colors.white
                                .withOpacity(0.08),
                          ),
                        );
                      },
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

  Widget glassCard({
    required Widget child,
  }) {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(30),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),

        child: Container(

          padding: const EdgeInsets.all(22),

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

          child: child,
        ),
      ),
    );
  }

  Widget topButton(
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
        ),

        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget infoItem(
      String title,
      String value,
      ) {

    return Column(

      children: [

        Text(

          title,

          style:
          GoogleFonts.inter(

            color: Colors.white54,
          ),
        ),

        const SizedBox(height: 8),

        Text(

          value,

          style:
          GoogleFonts.poppins(

            color: Colors.white,

            fontWeight:
            FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget quantityButton(
      IconData icon,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        width: 42,
        height: 42,

        decoration: BoxDecoration(

          shape: BoxShape.circle,

          color:
          Colors.white.withOpacity(0.08),
        ),

        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget actionButton(
      String title,
      Color color,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        height: 60,

        decoration: BoxDecoration(

          borderRadius:
          BorderRadius.circular(22),

          color: color,
        ),

        child: Center(

          child: Text(

            title,

            style:
            GoogleFonts.poppins(

              color: Colors.white,

              fontWeight:
              FontWeight.w600,

              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
