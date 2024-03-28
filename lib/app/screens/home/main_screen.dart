import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maderkinkao/app/screens/settings/main.dart';
import 'package:maderkinkao/app/utils/constants.dart';
import 'package:maderkinkao/app/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/bottombar.dart';
import '../store/components/profile.dart';
import 'home.dart';

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  int currentIndex = 0;
  bool _isAuth = false;
  final screens = [
    const MyHomeScreen(),
    const StoreProfile(),
    const MySettingsScreen()
    // const MyProfile(),
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
    return Responsive(
      mobile: mobileWidget(),
      tablet: mobileWidget(),
      desktop: desktopWidget()
      );
  }

  Widget mobileWidget() {
    return Scaffold(
      appBar: currentIndex == 0 ? AppBar(
        leading: null,
      ) : null,
      body: screens[currentIndex],
      bottomNavigationBar: MyBottomBar(onTabChange: _changePage,),
    );
  }

  Widget desktopWidget() {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: maxWidthMobile*0.75),
        child: Scaffold(
          appBar: currentIndex == 0 ? AppBar(
            leading: null,
          ) : null,
          body: screens[currentIndex],
          bottomNavigationBar: MyBottomBar(onTabChange: _changePage,),
        ),
      ),
    );
  }
}

// Scaffold(
//       appBar: currentIndex == 0 ? AppBar(
//         leading: null,
//       ) : null,
//       body: screens[currentIndex],
//       bottomNavigationBar: MyBottomBar(onTabChange: _changePage,),
//     );