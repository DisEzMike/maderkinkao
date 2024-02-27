import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/components/loading.dart';
import 'package:maderkinkao/app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

import '../../services/auth.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
User? _currentUser;
bool _isAuth = false;
double coverHeight = 150;
double profileHeight = 140;
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) async {
      String? userId = prefs.getString('userId');
      if (userId != null) {
        final _user = await getUser(userId);
        setState(() {
          _currentUser = _user;
          _isAuth = true;
        });
      } else {
        handleSignOut();
        context.pushReplacement('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAuth ? ListView(
        // physics: AlwaysScrollableScrollPhysics(),
        children:[
          buildTop(context),
          buildContent(context)
        ],
      ) : const Loading(),
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
                color: Colors.deepOrange.shade600,
                ),
            ),
          

            Positioned(
                  top: coverHeight - 20,
                  child: Container(
                    width: _size.width,
                    height: kDefaultPadding * 5,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.horizontal(left: Radius.circular(kDefaultPadding), right: Radius.circular(kDefaultPadding))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        const SizedBox(height: kDefaultPadding * 1.5),
                        SizedBox(width: _size.width, child: const Divider(),),
                      ],),
                    ),
                  ),
                ),


            Positioned(
              top: coverHeight - profileHeight / 2 - 20,
              child: CircleAvatar(
                radius: profileHeight / 2 + 10,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: profileHeight / 2,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: NetworkImage(_currentUser!.photoUrl!),
                ),
              ),
            ),

            Positioned(
              top: coverHeight + profileHeight / 2,
              child: Text("${_currentUser?.displayName}", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize * 1.5, fontWeight: FontWeight.w400)),),
            ),
          ],
    );
  }

  Widget buildContent(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: _size.height - coverHeight - profileHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(kDefaultPadding+kDefaultPadding/4),
              child: GestureDetector(
                onTap: signOut,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade500,
                    borderRadius: BorderRadius.circular(kDefaultPadding)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*2, vertical: kDefaultPadding/2),
                    child: Center(child: Text("ออกจากระบบ", style: GoogleFonts.kanit(textStyle: const TextStyle(color: Colors.white, fontSize: kDefaultFontSize*1.3, fontWeight: FontWeight.w600)))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signOut() async {
    bool isAuth = await handleSignOut();
    setState(() {
      _isAuth = isAuth;
    });

    context.pushReplacement('/login');
  }
}