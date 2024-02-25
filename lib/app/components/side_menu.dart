// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import '../utils/constants.dart';
import 'side_menu_item.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  
  double _selected = 0;

  ontab(double index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      // color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Image.asset(
              //       "assets/images/Logo Outlook.png",
              //       width: 46,
              //     ),
              //     Spacer(),
              //     // We don't want to show this close button on Desktop mood
              //     if (!Responsive.isDesktop(context)) CloseButton(),
              //   ],
              // ),
              SizedBox(height: kDefaultPadding),
              SizedBox(height: kDefaultPadding * 2),
              // Menu Items
              SideMenuItem(
                press: () => ontab(0),
                title: "Home",
                icons:  const [Icon(Icons.home_outlined), Icon(Icons.home)],
                isActive: _selected == 0,
              ),
              SideMenuItem(
                press: () => ontab(1),
                title: "Item 1",
                icons:  const [Icon(Icons.book_outlined), Icon(Icons.book)],
                isActive: _selected == 1,
              ),
              SideMenuItem(
                press: () => ontab(2),
                title: "Item 2",
                icons:  const [Icon(Icons.book_outlined), Icon(Icons.book)],
                isActive: _selected == 2,
                showBorder: false,
              ),
              SizedBox(height: kDefaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
