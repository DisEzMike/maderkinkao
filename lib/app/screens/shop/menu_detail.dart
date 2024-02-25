import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/cart.dart';
import '../../models/menu.dart';
import '../../utils/constants.dart';

class MenuDetail extends StatefulWidget {
  const MenuDetail({super.key, required this.id});

  final id;

  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  late Menu menu;
  int count_checked = 0;
  int count = 1;
  int addon = 0;
  double coverHeight = 300;
  dynamic option = {};
  @override
  void initState() {
    menu = menus.where((element) => element.id == int.parse(widget.id)).toList()[0];
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTop(context),
          Container(child: buildBody(context)),
          buildCart(context)
        ],
      ),
    );
  }

  Widget buildTop(BuildContext context) {
     Size _size = MediaQuery.of(context).size;
    // final shopss = shops.where((element) => element.id == int.parse(widget.id)).toList();
    // if (shopss.isEmpty) context.pop();
    // Shop shop = shopss[0];

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
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: AssetImage(menu.image)
                    )
                  ),
            ),
          

            Positioned(
                  top: coverHeight - 20,
                  child: Container(
                    width: _size.width,
                    height: kDefaultPadding * 5,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.horizontal(left: Radius.circular(kDefaultPadding), right: Radius.circular(kDefaultPadding))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: kDefaultPadding * 1.5),
                        // SizedBox(width: _size.width, child: const Divider(),),
                      ],),
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
              // height: _size.height,
              child: Column(
                children: [
                  // Text("${shop.name}", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: kDefaultFontSize * 2, fontWeight: FontWeight.w500)),),
                  SizedBox(width: _size.width - kDefaultPadding, child: Text("${menu.name}", style: GoogleFonts.kanit(textStyle : const TextStyle(fontSize: kDefaultFontSize*2,fontWeight: FontWeight.w500)),)),
                  // SizedBox(width: _size.width - kDefaultPadding,child: 
                  //   Text("${menu.detail}", style: GoogleFonts.kanit(textStyle: const TextStyle(fontWeight: FontWeight.w300)),)
                  // ),
                  // const SizedBox(height: kDefaultPadding,),
                  // SizedBox(width: _size.width - kDefaultPadding, child: const Divider(),),
                ],
              ),
            ),
          ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: kDefaultPadding*2),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (menu.option.toString() != "{}") ...menu.option['item'].map((e) => 
            CheckboxListTile(
              enabled: option[e['id']] == 1 || count_checked < int.parse(menu.option['max'].toString()),
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
            )
          ).toList(),

          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text("เพิ่มเติม", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize * 1.1, fontWeight: FontWeight.w600)),),
                Card(
                  color: Colors.grey.shade200,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 2, //or null 
                      decoration: InputDecoration.collapsed(hintText: "เพิ่มเติม..."),
                    ),
                  )
                )
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
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.remove,),
                              onPressed: decressCount,
                            ),
                          ),
                  
                          SizedBox(
                            width: kDefaultPadding*2,
                            child: Center(
                              child: Text(count.toString()),
                              ),
                          ),
                  
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.add,),
                              onPressed: incressCount,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: kDefaultPadding),

                      Expanded(
                        child: ElevatedButton(
                              onPressed: () {
                                List<dynamic> option_addon = [];
                                if (menu.option.toString() != "{}") option_addon = menu.option['item'].map((e) => option[e['id']] == 1 ? e : null).toList().where((e) => e != null).toList();

                                // final data = {
                                //   "menuId": menu.id,
                                //   "addon": option_addon,
                                //   "comment": "",
                                //   "count": count,
                                //   "price" : (menu.price + addon)
                                // };
                                context.pop(Cart(menu.id, option_addon, "", count, (menu.price + addon)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("เพิ่มลงตะกร้า", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2)),),
                                    Text(((menu.price + addon) * count).toStringAsFixed(2), style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2))),
                                  ],
                                ),
                              )
                            ),
                      )
                    ],
                  ),
                )
            ],),
          );
  }
}