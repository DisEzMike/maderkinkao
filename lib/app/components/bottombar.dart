// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../utils/constants.dart';

class MyBottomBar extends StatelessWidget {
  MyBottomBar({super.key, required this.onTabChange});

  final void Function(int)? onTabChange;

  final List list = [
    {"icon" : Icons.home, "text": "หน้าแรก"},
    {"icon" : Icons.person, "text": "โปรไฟล์"},
    // {"icon" : Icons.login, "text": "login"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.deepOrange.shade500,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2, vertical: kDefaultPadding),
            child: GNav(
                onTabChange: onTabChange,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // backgroundColor: Colors.deepOrange,
                color: Colors.white,
                activeColor: Colors.deepOrange.shade500,
                tabBackgroundColor: Colors.white,
                gap: 10,
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*1.5, vertical: kDefaultPadding),
                tabs: list.map((e) => GButton(icon: e["icon"], text: e['text'], textStyle: gNavTextStyle,)).toList()
                ),
          ),
        );
  }
}