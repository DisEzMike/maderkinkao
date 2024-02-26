// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/cart.dart';
import '../../../models/menu.dart';
import '../../../models/shop.dart';
import '../../../utils/constants.dart';
import 'menu_card.dart';

class ShopMenu extends StatefulWidget {
  const ShopMenu({super.key, required this.id});

  final id;

  @override
  State<ShopMenu> createState() => _ShopMenuState();
}

class _ShopMenuState extends State<ShopMenu> {
  List<Menu> menu_list = [];

  List<Cart> cart_list = [];
  @override
  void initState() {
    menu_list = menus
        .where((element) => element.shopId == int.parse(widget.id))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _canPop = false;
    Size _size = MediaQuery.of(context).size;

    final shopss =
        shops.where((element) => element.id == int.parse(widget.id)).toList();
    if (shopss.isEmpty) context.pop();

    return PopScope(
      canPop: _canPop,
      onPopInvoked: (didPop) => _canPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () async {
              if (cart_list.isEmpty) {
                _canPop = true;
                return context.pop();
              }
              final result = await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
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

              if (result == "OK") {
                _canPop = true;
                context.pop();
              }
            },
          ),
          // backgroundColor: Colors.transparent,
        ),
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
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            buildTop(context),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: 150 - 144 / 3),
              child: Column(
                children: [
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
                                .push("/shop/${widget.id}/${e.id}")) as Cart?;
                            if (data != null) cart_list.add(data);
                          },
                          isLast: e == menu_list.last,
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildTop(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double coverHeight = 150;

    final shopss =
        shops.where((element) => element.id == int.parse(widget.id)).toList();
    if (shopss.isEmpty) context.pop();
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

        // Positioned(
        //   top: coverHeight - profileHeight / 2 - 20,
        //   child: CircleAvatar(
        //     radius: profileHeight / 2 + 10,
        //     backgroundColor: Colors.white,
        //     child: CircleAvatar(
        //       radius: profileHeight / 2,
        //       backgroundColor: Colors.grey.shade800,
        //       backgroundImage: AssetImage("assets/images/image.jpg"),
        //     ),
        //   ),
        // ),

        Positioned(
          top: coverHeight,
          child: Column(
            children: [
              // Text("${shop.name}", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: kDefaultFontSize * 2, fontWeight: FontWeight.w500)),),
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
              SizedBox(
                width: _size.width - kDefaultPadding,
                child: Divider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
