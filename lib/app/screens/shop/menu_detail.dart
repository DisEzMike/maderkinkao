import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/utils/responsive.dart';

import '../../models/cart.dart';
import '../../models/menu.dart';
import '../../utils/constants.dart';

class MenuDetail extends StatefulWidget {
  const MenuDetail({super.key, required this.id, this.viewOnly = false});

  final id;
  final bool viewOnly;
  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  late Menu menu;
  int count_checked = 0;
  int count = 1;
  int addon = 0;
  double coverHeight = 250;
  dynamic option = {};
  bool isbtnActivate = false;
  TextEditingController? _controller;
  @override
  void initState() {
    menu = menus
        .where((element) => element.id == int.parse(widget.id))
        .toList()[0];
    _controller = TextEditingController();
    super.initState();
  }

  void decressCount() {
    setState(() {
      count > 1 ? count-- : 1;
    });
  }

  void incressCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: mobileWidget(),
        tablet: mobileWidget(),
        desktop: desktopWidget());
  }

  Widget mobileWidget() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTop(context),
          const SizedBox(height: kDefaultPadding * 2),
          Container(child: buildBody(context)),
          if (!widget.viewOnly) buildCart(context)
        ],
      ),
    );
  }

  Widget desktopWidget() {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: maxWidthMobile * 0.75),
        child: Scaffold(
          body: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: const BackButton(
                color: Colors.white,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTop(context),
                const SizedBox(height: kDefaultPadding * 2),
                Container(child: buildBody(context)),
                if (!widget.viewOnly) buildCart(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTop(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: AssetImage(menu.image))),
        ),
        Positioned(
          top: coverHeight - 20,
          width: Responsive.isDesktop(context) ? maxWidthTablet * 0.75 : null,
          child: Container(
            width: _size.width,
            height: kDefaultPadding * 5,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(kDefaultPadding),
                    right: Radius.circular(kDefaultPadding))),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: kDefaultPadding * 1.5),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: coverHeight,
          width: Responsive.isDesktop(context) ? maxWidthTablet * 0.70 : null,
          child: Column(
            children: [
              SizedBox(
                  width: _size.width - kDefaultPadding,
                  child: Text(
                    "${menu.name}",
                    style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                            fontSize: kDefaultFontSize * 2,
                            fontWeight: FontWeight.w500)),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: kDefaultPadding),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: kDefaultPadding),
          if (menu.option.toString() != "{}")
            ...menu.option['item']
                .map((e) => CheckboxListTile(
                      enabled: !widget.viewOnly &&
                          (option[e['id']] == 1 ||
                              count_checked <
                                  int.parse(menu.option['max'].toString())),
                      title: Text("${e['name']} +${e['price']}"),
                      value: option[e['id']] == 1,
                      onChanged: (value) => {
                        option[e['id']] == null ? option[e['id']] = 0 : null,
                        setState(() {
                          if (option[e['id']] == 0) {
                            count_checked++;
                            addon += int.parse(e['price'].toString());
                            option[e['id']] = 1;
                          } else {
                            count_checked--;
                            addon -= int.parse(e['price'].toString());
                            option[e['id']] = 0;
                          }
                        })
                      },
                    ))
                .toList(),
          if (!widget.viewOnly)
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    "เพิ่มเติม",
                    style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                            fontSize: kDefaultFontSize * 1.1,
                            fontWeight: FontWeight.w600)),
                  ),
                  Card(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controller,
                          maxLines: 2, //or null
                          decoration: const InputDecoration.collapsed(
                              hintText: "เพิ่มเติม..."),
                        ),
                      ))
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget buildCart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(
                          Icons.remove,
                        ),
                        onPressed: decressCount,
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding * 2,
                      child: Center(
                        child: Text(count.toString()),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                        ),
                        onPressed: incressCount,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  child: ElevatedButton(
                      onPressed: validCheck()
                          ? () {
                              List<dynamic> option_addon = [];
                              if (menu.option.toString() != "{}") {
                                option_addon = menu.option['item']
                                    .map((e) => option[e['id']] == 1 ? e : null)
                                    .toList()
                                    .where((e) => e != null)
                                    .toList();
                              }
                              // final data = {
                              //   "menuId": menu.id,
                              //   "addon": option_addon,
                              //   "comment": "",
                              //   "count": count,
                              //   "price" : (menu.price + addon)
                              // };
                              context.pop(Cart(
                                  menu.id,
                                  option_addon,
                                  _controller?.text ?? "",
                                  count,
                                  (menu.price + addon)));
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "เพิ่มลงตะกร้า",
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                      fontSize: kDefaultFontSize * 1.2)),
                            ),
                            Text(
                                ((menu.price + addon) * count)
                                    .toStringAsFixed(2),
                                style: GoogleFonts.kanit(
                                    textStyle: const TextStyle(
                                        fontSize: kDefaultFontSize * 1.2))),
                          ],
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool validCheck() {
    if (menu.option.toString() == '{}') return true;
    final max = menu.option['max'];
    return count_checked == max;
  }
}
