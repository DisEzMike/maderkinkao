import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maderkinkao/app/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isAuth = false;
  GoogleSignInAccount? _currentUser;
  final screens = [
    const MyHomeScreen(),
    const MyProfile(),
    const MyLoginPage()
    // const GoogleSignIn(),
  ];

  _changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) => {
      _isAuth = prefs.getBool('auth') ?? false,

      if (!_isAuth) {
        context.pushReplacement('/login'),
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0 ? AppBar(
        leading: null,
      ) : null,
      body: screens[currentIndex],
      bottomNavigationBar: MyBottomBar(onTabChange: _changePage,),
    );
  }
}
