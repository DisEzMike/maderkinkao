// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import 'components/list_of_shop.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // It provide us the width and height

    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Responsive(
        // Let's work on our mobile part
        mobile: ListofShop(),
        tablet: Scaffold(
          backgroundColor: Colors.green,
        ),
        desktop: Scaffold(
          backgroundColor: Colors.grey.shade200,
        )
      ),
    );
  }
}
