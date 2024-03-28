// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/utils/responsive.dart';

import '../../../models/menu.dart';
import '../../../utils/constants.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menu,
    required this.score,
    required this.review,
    this.isLast = false,
    required this.press,
    this.viewOnly = false,
  });

  final bool isLast;
  final Menu menu;
  final VoidCallback press;
  final double score;
  final int review;
  final bool viewOnly;
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
                  // height: 250,
                  decoration: BoxDecoration(
                      // color: isActive ? kPrimaryColor : kBgDarkColor,
                      // borderRadius: BorderRadius.circular(kDefaultPadding),
                      ),
                  child: Column(
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Expanded(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  kDefaultPadding / 5), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(
                                    Responsive.isMobile(context)
                                        ? 65
                                        : 120), // Image radius
                                child:
                                    Image.asset(menu.image, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Expanded(
                              flex: 5,
                              child: SizedBox(
                                height: 125,
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 175,
                                        child: Text(menu.name,
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                fontSize:
                                                    kDefaultFontSize * 1.2,
                                              ),
                                            ))),
                                    SizedBox(
                                      width: 175,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${menu.price.toStringAsFixed(2)} บาท",
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                    fontSize:
                                                        kDefaultFontSize * 1.2,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          if (!viewOnly)
                                            Icon(
                                              Icons.add_circle_outline,
                                              size: kDefaultFontSize * 1.5,
                                              color: Colors.black,
                                            )
                                        ],
                                      ),
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
          else
            SizedBox(
              height: kDefaultPadding,
            )
        ],
      ),
    );
  }
}
