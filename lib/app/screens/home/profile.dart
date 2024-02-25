import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/constants.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // physics: AlwaysScrollableScrollPhysics(),
        children: [
          buildTop(context),
          buildContent()
        ],
      ),
    );
  }

  Widget buildTop(BuildContext context) {
     Size _size = MediaQuery.of(context).size;
     double coverHeight = 150;
     double profileHeight = 140;

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
                  backgroundImage: AssetImage("assets/images/image.jpg"),
                ),
              ),
            ),

            Positioned(
              top: coverHeight + profileHeight / 2,
              child: Text("ณัชพล สหัสสเนตร", style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: kDefaultFontSize * 1.5, fontWeight: FontWeight.w400)),),
            ),
          ],
    );
  }

  Widget buildContent() {
    return Container(
      child: Column(
        children: [

        ],
      ),
    );
  }
}