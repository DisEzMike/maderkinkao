import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/cart.dart';
import '../../../utils/constants.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.data});

  final Cart data;

  @override
  Widget build(BuildContext context) {
    List<dynamic> addon = data.addon;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Text('${data.count}', style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w500)),),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Text("${data.menu.name}", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w400)))
                ],
              ),
              ...addon.map((e) => Row(
                children: [
                  const SizedBox(width: kDefaultPadding),
                  Text("+${e['price']} ${e['name']}", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w400)))
                ],
              )),
              
            ],
          ),
          Text("${(data.price * data.count).toStringAsFixed(2)} บาท", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w500)))
        ],
      ),
    );
  }
}