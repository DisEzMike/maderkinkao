import 'package:flutter/material.dart';

import '../../components/bottombar.dart';
import 'home.dart';
import 'profile.dart';

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  int currentIndex = 0;
  final screens = [
    const MyHomeScreen(),
    const MyProfile(),
    // const GoogleSignIn(),
  ];

  _changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0 ? AppBar() : null,
      body: screens[currentIndex],
      bottomNavigationBar: MyBottomBar(onTabChange: _changePage,),
    );
  }
}
