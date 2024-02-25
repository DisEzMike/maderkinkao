// ignore_for_file: prefer_const_constructors

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/shop.dart';
import '../../../utils/constants.dart';
import 'shop_card.dart';

class ListofShop extends StatefulWidget {
  const ListofShop({super.key});

  @override
  State<ListofShop> createState() => _ListofShopState();
}

List<String> list = <String>['โรงอาหาร C', 'Two', 'Three', 'Four'];

class _ListofShopState extends State<ListofShop> {
  String? dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 1.5),
        children: [
          Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: gNavBoxDecoration,
                    child: DropdownButtonFormField<String>(
                        value: dropdownValue,
                        borderRadius: BorderRadius.circular(kDefaultPadding),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 3,
                                horizontal: kDefaultPadding / 2),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultPadding)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultPadding),
                                borderSide: const BorderSide(
                                  color: Colors.black26,
                                  width: 1,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultPadding),
                                borderSide: const BorderSide(
                                    color: Colors.black26, width: 1)),
                            filled: true,
                            fillColor: Colors.white),
                        style: GoogleFonts.kanit(textStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                          // fontWeight: FontWeight.bold
                        )),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                        items: list
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding * 1.5),
                    child: DecoratedBox(
                      decoration: gNavBoxDecoration,
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'ค้นหาร้านอาหารที่ใช่',
                            labelStyle: const TextStyle(
                                color: Colors.black, letterSpacing: 1.2),
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultPadding),
                                borderSide: const BorderSide(
                                  color: Colors.black26,
                                  width: 1,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultPadding),
                                borderSide: const BorderSide(
                                  color: Colors.black26,
                                  width: 1,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultPadding),
                                borderSide: const BorderSide(
                                    color: Colors.black26, width: 1)),
                            filled: true,
                            fillColor: Colors.white),
                        style: const TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.1,
                          fontSize: kDefaultFontSize * 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: kDefaultPadding/2,
            ),
            ...shops.map((e) => ShopCard(shop: e, press: () {
              context.push("/shop/${e.id}");
              // Navigator.pushNamed(context, '/shop');
            }, isLast: e == shops.last,))
            // ...menus.map((e) => MenuCard(menu: e, score: 4.3, review: 100, press: () {}, isLast: e == menus.last,))
        ],
      ),
    );
  }
}
