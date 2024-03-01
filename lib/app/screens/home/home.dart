// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maderkinkao/app/models/shop.dart';
import 'package:maderkinkao/app/screens/home/components/search_form.dart';
import 'package:maderkinkao/app/screens/home/components/shop_card.dart';
import 'package:maderkinkao/app/utils/constants.dart';

import '../../utils/responsive.dart';

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
          mobile: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
            children: [
              SearchForm(),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              ...shops.map((e) => ShopCard(
                    shop: e,
                    press: () {
                      context.push("/shop/${e.id}");
                    },
                    isLast: e == shops.last,
                  ))
            ],
          ),
          tablet: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
            children: [
              SearchForm(),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              ...shops.map((e) => ShopCard(
                    shop: e,
                    press: () {
                      context.push("/shop/${e.id}");
                    },
                    isLast: e == shops.last,
                  ))
            ],
          ),
          desktop: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 5),
            children: [
              SearchForm(),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              ...shops.map((e) => ShopCard(
                    shop: e,
                    press: () {
                      context.push("/shop/${e.id}");
                    },
                    isLast: e == shops.last,
                  ))
            ],
          )),
    );
  }
}
