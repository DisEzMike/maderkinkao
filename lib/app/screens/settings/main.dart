// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/components/loading.dart';
import 'package:maderkinkao/app/models/user.dart';
import 'package:maderkinkao/app/screens/settings/components/setting_card.dart';
import 'package:maderkinkao/app/screens/settings/components/user_card.dart';
import 'package:maderkinkao/app/services/auth.dart';
import 'package:maderkinkao/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/responsive.dart';

class MySettingsScreen extends StatefulWidget {
  const MySettingsScreen({super.key});

  @override
  State<MySettingsScreen> createState() => _MySettingsScreenState();
}

class _MySettingsScreenState extends State<MySettingsScreen> {
  double coverHeight = 250;
  double profileHeight = 144;
  User? _currentUser;
  bool _isLoading = true;

  List cards = [
    {"icon": Icons.history, "title": "ประวัติการสั่งซื้อ", "path": '/user/history'},
    {"icon": Icons.add, "title": "เพิ่มร้านค้า", "path": '/admin/shop/add'},
    {"icon": Icons.storefront, "title": "แก้ไขร้านค้า", "path": '/shop'},
    {"icon": Icons.shopping_basket_outlined, "title": "ออเดอร์", "path": '/shop/order'},
  ];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      String? userId = prefs.getString('userId');
      if (userId != null) {
        getUser(userId).then((_user) {
          setState(() {
            _currentUser = _user;
            if (_currentUser == null) context.pushReplacement('/login');
            _isLoading = false;
          });
        // ignore: invalid_return_type_for_catch_error
        }).catchError((e) => print(e));
      } else {
        handleSignOut();
        context.pushReplacement('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // It provide us the width and height

    Size _size = MediaQuery.of(context).size;

    return _isLoading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: Responsive(
        // Let's work on our mobile part
        mobile: Scaffold(
          appBar: AppBar(
            title: Text("การตั้งค่า"),
            centerTitle: true,
            backgroundColor: Colors.grey.shade200,
          ),
          backgroundColor: Colors.grey.shade200,
          body: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
                Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    UserCard(user: _currentUser!),
                    SizedBox(height: kDefaultPadding*2),
                    ...cards.map((e) => SettingCard(icon: e['icon'], title: e['title'], path: e['path'])).toList(),
                    SizedBox(height: kDefaultPadding),
                    SignOutButton(context)
                  ]
                ),
              )
            ]
          ),
        ),
        tablet: Scaffold(
          appBar: AppBar(
            title: Text("การตั้งค่า"),
            centerTitle: true,
            backgroundColor: Colors.grey.shade200,
          ),
          backgroundColor: Colors.grey.shade200,
          body: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
                Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    UserCard(user: _currentUser!),
                    SizedBox(height: kDefaultPadding*2),
                    ...cards.map((e) => SettingCard(icon: e['icon'], title: e['title'], path: e['path'])).toList(),
                    SizedBox(height: kDefaultPadding),
                    SignOutButton(context)
                  ]
                ),
              )
            ]
          ),
        ),
        desktop: Scaffold(
          appBar: AppBar(
            title: Text("การตั้งค่า"),
            centerTitle: true,
            backgroundColor: Colors.grey.shade200,
          ),
          backgroundColor: Colors.grey.shade200,
          body: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
                Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    UserCard(user: _currentUser!),
                    SizedBox(height: kDefaultPadding*2),
                    ...cards.map((e) => SettingCard(icon: e['icon'], title: e['title'], path: e['path'])).toList(),
                    SizedBox(height: kDefaultPadding),
                    SignOutButton(context)
                  ]
                ),
              )
            ]
          ),
        )
      ),
    );
  }

  Widget SignOutButton(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: signOut,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.deepOrange.shade500,
          borderRadius: BorderRadius.circular(kDefaultPadding/2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*2, vertical: kDefaultPadding/2),
          child: Center(child: Text("ออกจากระบบ", style: GoogleFonts.kanit(textStyle: const TextStyle(color: Colors.white, fontSize: kDefaultFontSize*1.3, fontWeight: FontWeight.w600)))),
        ),
      ),
    );
  }

  void signOut() async {
    bool isAuth = await handleSignOut();
    context.pushReplacement('/login');
  }  
}
