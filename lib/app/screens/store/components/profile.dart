// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/cart.dart';
import '../../../models/menu.dart';
import '../../../models/shop.dart';
import '../../../utils/constants.dart';
import '../../shop/components/menu_card.dart';

class StoreProfile extends StatefulWidget {
  const StoreProfile({super.key});

  @override
  State<StoreProfile> createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  List<Menu> menu_list = [];

  List<Cart> cart_list = [];

  final bool viewOnly = true;
  @override
  void initState() {
    menu_list = menus
        .where((element) => element.shopId == 1)
        .toList();
    super.initState();
  }

  _showDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop('Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.pop('OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final shopss = shops.where((element) => element.id == 1).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: cart_list.isNotEmpty
          ? Container(
              child: FittedBox(
                child: Stack(
                  alignment: Alignment(1.4, -1.5),
                  children: [
                    FloatingActionButton(
                      // Your actual Fab
                      onPressed: () {
                        context.push('/cart', extra: cart_list).then((data) => {
                          if (data != null) {
                            setState(() {
                              cart_list = data as List<Cart>;
                            })
                          }
                        });
                      },
                      child: Icon(Icons.shopping_basket_rounded),
                      backgroundColor: Colors.white,
                    ),
                    Container(
                      // This is your Badge
                      child: Center(
                        // Here you can put whatever content you want inside your Badge
                        child: Text('${cart_list.length}',
                            style: TextStyle(color: Colors.white)),
                      ),
                      padding: EdgeInsets.all(8),
                      constraints:
                          BoxConstraints(minHeight: 32, minWidth: 32),
                      decoration: BoxDecoration(
                        // This controls the shadow
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: Colors.black.withAlpha(50))
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.deepOrange
                            .shade600, // This would be color of the Badge
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          buildTop(context),
          buildContent(context)
        ],
      ),
    );
  }

  Widget buildTop(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double coverHeight = 200;

    final shopss =
        shops.where((element) => element.id == 1).toList();
    Shop shop = shopss[0];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: _size.width,
          height: coverHeight,
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: AssetImage(shop.image))),
        ),

        Positioned(
          top: coverHeight - 20,
          child: Container(
            width: _size.width,
            height: kDefaultPadding * 5,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(kDefaultPadding),
                    right: Radius.circular(kDefaultPadding))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kDefaultPadding * 1.5),
                  // SizedBox(width: _size.width, child: const Divider(),),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: coverHeight,
          child: Column(
            children: [
              SizedBox(
                  width: _size.width - kDefaultPadding,
                  child: Text(
                    "${shop.name}",
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            fontSize: kDefaultFontSize * 2,
                            fontWeight: FontWeight.w500)),
                  )),
              SizedBox(
                width: _size.width - kDefaultPadding,
                child: Row(
                  children: [
                    Icon(
                      Icons.star_border,
                      color: Colors.yellow.shade800,
                    ),
                    Text(
                      " ${shop.score} / 5 (${shop.review} รีวิว)",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(fontWeight: FontWeight.w300)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: 150 - 144 / 2),
      child: Column(
        children: [
          SizedBox(
            width: _size.width - kDefaultPadding,
            height: kDefaultPadding*2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.deepOrange.shade500),
                borderRadius: BorderRadius.circular(kDefaultPadding/5),
                color: Colors.deepOrange.shade500
              ),
              child: TextButton.icon(onPressed: () {}, label: Text("แก้ไขร้านค้า"), icon: Icon(Icons.edit), style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.transparent),)),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          SizedBox(
            width: _size.width - kDefaultPadding,
            child: Divider(),
          ),
          if (menu_list.isNotEmpty)
            SizedBox(
                width: _size.width - kDefaultPadding,
                child: Text(
                  "เมนู",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontSize: kDefaultFontSize * 2,
                          fontWeight: FontWeight.w500)),
                )),
          if (menu_list.isNotEmpty)
            ...menu_list.map((e) => MenuCard(
                  menu: e,
                  score: 4.3,
                  review: 100,
                  press: () async {
                    final Cart? data = (await context
                        .push("/shop/1/${e.id}", extra: viewOnly)) as Cart?;
                    if (data != null) cart_list.add(data);
                  },
                  isLast: e == menu_list.last,
                  viewOnly: viewOnly,
                ))
          else
            SizedBox(
                width: _size.width - kDefaultPadding,
                child: Text(
                  "ยังไม่มีเมนู...",
                  style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontSize: kDefaultFontSize * 1.5,
                          fontWeight: FontWeight.w500)),
                ))
        ],
      ),
    );
  }
}
