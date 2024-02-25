// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';

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
        mobile: ShopMenu(id: id),
        tablet: Scaffold(
          backgroundColor: Colors.green,
        ),
        desktop: Scaffold(
          backgroundColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}