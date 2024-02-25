import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const maxWidthMobile = 650;
const maxWidthTablet = 1100;

const kDefaultPadding = 20.0;

const kPrimaryColor = Color(0xFF366CF6);
const kSecondaryColor = Color(0xFFF5F6FC);
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kBadgeColor = Color(0xFFEE376E);
const kGrayColor = Color(0xFF8793B2);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);

final gNavTextStyle = GoogleFonts.kanit(textStyle: const TextStyle(letterSpacing: 1.2, color: Colors.deepOrange));
const gNavBoxDecoration = BoxDecoration(boxShadow: <BoxShadow>[
  BoxShadow(
    color: Colors.black,
    offset: Offset(0, 5),
    blurRadius: 10,
    spreadRadius: -10,
  ),
]);
