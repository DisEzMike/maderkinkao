// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:maderkinkao/app/utils/constants.dart';

import '../../utils/responsive.dart';
import 'components/shop_menu.dart';

class MyShopScreen extends StatelessWidget {
  const MyShopScreen({super.key, required this.id});

  final id;

  @override
  Widget build(BuildContext context) {
        Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.deepOrange,
      body: Responsive(
        // Let's work on our mobile part
        mobile: mobileWidget(),
        tablet: mobileWidget(),
        desktop: desktopWidget(),
      ),
    );
  }

  Widget mobileWidget() {
    return Scaffold(
      body: ShopMenu(id: id),
    );
  }

  Widget desktopWidget() {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: maxWidthMobile*0.75),
        child: Scaffold(
          body: ShopMenu(id: id),
        ),
      ),
    );
  }
}