import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/utils/methods.dart';
import 'package:maderkinkao/app/utils/responsive.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/cart.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import '../../utils/constants.dart';
import 'components/cart_card.dart';

final List<dynamic> paymentMethod = [
  {"name": "PromptPay", "path": 'assets/images/promptpay.png'},
];

class MyCart extends StatefulWidget {
  const MyCart({super.key, required this.items});

  final List<Cart> items;
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<Cart> menu_items = [];
  int count = 0;
  double total = 0;
  int index = 0;
  User? _currentUser;

  int selectedPayment = -1;
  bool isUploaded = false;
  String title = 'อัพโหลดไฟล์';
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
    ref
        .doc("${menu_items[0].shopId}")
        .collection('orders')
        .orderBy('queue', descending: false)
        .get()
        .then((orders) {
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
        "payment": selectedPayment,
        "status": 0,
        "queue": queue
      };

      ref
          .doc("${menu_items[0].shopId}")
          .collection('orders')
          .doc(id)
          .set(payload)
          .then((_) => {
                setState(() {
                  menu_items = [];
                }),
                context.pop(menu_items)
                // ignore: invalid_return_type_for_catch_error
              })
          // ignore: invalid_return_type_for_catch_error
          .catchError((e) => print(e));
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
    return Responsive(
        mobile: mobileWidget(),
        tablet: mobileWidget(),
        desktop: desktopWidget());
  }

  Widget mobileWidget() {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.deepOrange.shade500,
        title: Text(
          "ตะกร้าสินค้า",
          style: GoogleFonts.kanit(
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
        shadowColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: kDefaultPadding),
                Text(
                  "รายการอาหาร",
                  style: GoogleFonts.kanit(
                      textStyle: const TextStyle(
                          fontSize: kDefaultFontSize * 1.2,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: kDefaultPadding),
                ...menu_items.map((e) => CartCard(data: e)).toList(),
                const SizedBox(height: kDefaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("รวม",
                          style: GoogleFonts.kanit(
                              textStyle: const TextStyle(
                                  fontSize: kDefaultFontSize * 1.2,
                                  fontWeight: FontWeight.w500))),
                      Text("${total.toStringAsFixed(2)} บาท",
                          style: GoogleFonts.kanit(
                              textStyle: const TextStyle(
                                  fontSize: kDefaultFontSize * 1.2,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: kDefaultPadding),
                Text(
                  "การชำระเงิน",
                  style: GoogleFonts.kanit(
                      textStyle: const TextStyle(
                          fontSize: kDefaultFontSize * 1.2,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: kDefaultPadding),
                CustomPaymentCardButton('assets/images/promptpay.png', 0),
                if (selectedPayment == 0) ...[
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: QRCodeGenerate(
                      promptPayId: "0915594555",
                      amount: total,
                      isShowAccountDetail: false,
                      width: 350,
                      height: 350,
                      amountDetailCustom: Text("จำนวน: $total บาท", style: GoogleFonts.kanit(textStyle: const TextStyle(fontWeight: FontWeight.w600))),
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  fileUploadButton(),
                  const SizedBox(height: kDefaultPadding * 5)
                ]
              ],
            ),
          ),
          buildCart(context)
        ],
      ),
    );
  }

  Widget desktopWidget() {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: maxWidthMobile * 0.75),
        child: mobileWidget(),
      ),
    );
  }

  Widget buildCart(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, -6),
            blurRadius: 10,
            spreadRadius: -10,
          )
        ],
      ),
      child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(kDefaultPadding + kDefaultPadding / 4),
          child: GestureDetector(
            onTap: paymentCheck() ? () => _purchase() : null,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: paymentCheck()
                      ? Colors.deepOrange.shade500
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(kDefaultPadding)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 2,
                    vertical: kDefaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 1.2,
                              vertical: kDefaultPadding / 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding)
                              // border: Border.all(color: Colors.grey.shade300)
                              ),
                          child: Text(
                            '${count}',
                            style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                    fontSize: kDefaultFontSize * 1.2,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 1.5),
                        Text("สั่งซื้อ",
                            style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: kDefaultFontSize * 1.3,
                                    fontWeight: FontWeight.w600)))
                      ],
                    ),
                    Text("${total.toStringAsFixed(2)} บาท",
                        style: GoogleFonts.kanit(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: kDefaultFontSize * 1.3,
                                fontWeight: FontWeight.w600)))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget CustomPaymentCardButton(String assetName, int index) {
    return OutlinedButton(
      onPressed: () {
        if (selectedPayment != index) {
          setState(() {
            selectedPayment = index;
          });
        } else {
          setState(() {
            selectedPayment = -1;
          });
        }
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (selectedPayment == index) ? 2.0 : 0.5,
            color: (selectedPayment == index)
                ? Colors.green
                : Colors.blue.shade600),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Center(
              child: Image.asset(
                assetName,
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
          ),
          if (selectedPayment == index)
            Positioned(
              top: 5,
              right: 5,
              child: Image.asset(
                "assets/images/tick.png",
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

  bool paymentCheck() {
    bool valid = false;
    if (selectedPayment != -1 && isUploaded) valid = true;
    return valid;
  }

  Widget fileUploadButton() {
    return TextButton(
      child: Text(title),
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          // Uint8List fileBytes = result.files.first.bytes as dynamic;
          String fileName = result.files.first.name;

          setState(() {
            isUploaded = true;
            title = fileName;
          });
          // Upload file
          // final FirebaseFirestore db = FirebaseFirestore.instance;
          // db.collection('uploads').doc(fileName).set(fileBytes as dynamic);
        }
      },
    );
  }
}
