// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/shop.dart';
import '../../../utils/constants.dart';

class ShopCard extends StatelessWidget {
  const ShopCard(
      {super.key,
      this.isActive = true,
      this.isLast = false,
      required this.shop,
      required this.press});

  final bool isActive, isLast;
  final Shop shop;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Column(
        children: [
          InkWell(
            onTap: press,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(kDefaultPadding / 4),
                  decoration: BoxDecoration(
                      // color: isActive ? kPrimaryColor : kBgDarkColor,
                      // borderRadius: BorderRadius.circular(kDefaultPadding),
                      ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  kDefaultPadding / 5), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(65), // Image radius
                                child: Image.asset(shop.image, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 5),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 175,
                                        child: Text(shop.name,
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  fontSize: kDefaultFontSize * 1.2,
                                                  fontWeight: FontWeight.w500),
                                            ))),
                                    SizedBox(
                                      width: 175,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star_border,
                                            color: Colors.yellow.shade800,
                                          ),
                                          Text(
                                              "${shop.score} / 5 (${shop.review} รีวิว)", style: GoogleFonts.kanit(textStyle: TextStyle(fontWeight: FontWeight.w300)),)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 175,
                                      child: Text("ประเภทร้านอาหาร", style: GoogleFonts.kanit(textStyle: TextStyle(fontWeight: FontWeight.w300))),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isLast)
            Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: Divider(),
            )
          else SizedBox(height: kDefaultPadding,)
        ],
      ),
    );
  }
}
