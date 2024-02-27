import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/utils/methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/cart.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import '../../utils/constants.dart';
import 'components/cart_card.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key, required this.items});

  final List<Cart> items;
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<Cart> menu_items = [];
  int count = 0;
  double 
  total = 0;

  User? _currentUser;
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) async {
      String? userId = prefs.getString('userId');
      if (userId != null) {
        final _user = await getUser(userId);
        setState(() {
          _currentUser = _user;
        });
      } else {
        handleSignOut();
        context.pushReplacement('/login');
      }
    });    

    getData();
  }

  void _purchase() {
    print("clicked");
    final database = FirebaseFirestore.instance;
    final ref = database.collection('shops');

    final now = DateTime.now();
    ref.doc("${menu_items[0].shopId}").collection('orders').orderBy('queue', descending: false).get().then((orders) {
      final sameDayOrders = orders.docs.where((element) {
        final data = element.data();
        final createdAt_date = (data['createdAt'] as Timestamp).toDate();
        
        return createdAt_date.isSameDate(now);
      });

      int queue = 1;

      if (sameDayOrders.isNotEmpty) {
        final lastOrder = sameDayOrders.last.data();
        queue = int.parse("${lastOrder['queue']}") + 1;
      }
      var uuid = const Uuid();
      var id = uuid.v4();
      dynamic payload = {
        "id": id,
        "shopId": menu_items[0].shopId,
        "createdAt": Timestamp.fromDate(now),
        "data": menu_items.map((e) => e.toJson()),
        "price": total,
        "userId": _currentUser!.id,
        "status": 0,
        "queue": queue
      };
      
      
      ref.doc("${menu_items[0].shopId}").collection('orders').doc(id).set(payload).then((_) => {
        setState(() {
          menu_items = [];
        }),
        context.pop(menu_items)
      // ignore: invalid_return_type_for_catch_error
      }).catchError((e) => print(e));
    // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => print(e));

  }

  getData() {
    menu_items = widget.items;
    menu_items.forEach((element) { 
      count += element.count!;
      total += element.price! * element.count!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.items);
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.deepOrange.shade500,
        title: Text("ตะกร้าสินค้า", style: GoogleFonts.kanit(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),),
        leading: const BackButton(color: Colors.white,),
        shadowColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: kDefaultPadding),
                Text("รายการอาหาร", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w600)),),
                const SizedBox(height: kDefaultPadding),
                ...menu_items.map((e) => CartCard(data: e)).toList(),
                const SizedBox(height: kDefaultPadding),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("รวม", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w500))),
                //           Text("${total.toStringAsFixed(2)} บาท", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w500)))
                //         ],
                //       )
                //     ),
                // ),
                const Divider()
              ],
            ),
          ),
          buildCart(context)
        ],
      ),
    );
  }

// Widget buildCart(BuildContext context) {
//     return ElevatedButton(onPressed: () {}, child: child)
//   }


Widget buildCart(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(
          color: Colors.black,
          offset: Offset(0, -6),
          blurRadius: 10,
          spreadRadius: -10,
        )],
        
      ),
      child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(kDefaultPadding+kDefaultPadding/4),
              child: GestureDetector(
                onTap: () => _purchase(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade500,
                    borderRadius: BorderRadius.circular(kDefaultPadding)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*2, vertical: kDefaultPadding/2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/1.2, vertical: kDefaultPadding/5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(kDefaultPadding)
                                // border: Border.all(color: Colors.grey.shade300)
                              ),
                              child: Text('${count}', style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, fontWeight: FontWeight.w500)),),
                            ),
                            const SizedBox(width: kDefaultPadding/1.5),
                            Text("สั่งซื้อ", style: GoogleFonts.kanit(textStyle: const TextStyle(color: Colors.white, fontSize: kDefaultFontSize*1.3, fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Text("${total.toStringAsFixed(2)} บาท", style: GoogleFonts.kanit(textStyle: const TextStyle(color: Colors.white, fontSize: kDefaultFontSize*1.3, fontWeight: FontWeight.w600)))
                      ],
                    ),
                  ),
                ),
              )
            ),
    );
  }
}