import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/components/loading.dart';
import 'package:maderkinkao/app/models/user.dart';
import 'package:maderkinkao/app/utils/constants.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    double profileHeight = 75;
    return GestureDetector(
      onTap: () => context.push('/setting/profile'),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.deepOrange.shade500),
          borderRadius: BorderRadius.circular(kDefaultPadding/2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 5),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding/2),
          child: Row(
            children: [
              CircleAvatar(
                radius: profileHeight / 2 + 5,
                backgroundColor: Colors.deepOrange.shade500,
                child: CircleAvatar(
                  radius: profileHeight / 2 + 3,
                  backgroundColor: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: user.photoUrl!,
                    imageBuilder:(context, imageProvider) => CircleAvatar(
                      radius: profileHeight / 2,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => const Loading(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${user.displayName}", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.3)),),
                    Text("แก้ไขโปรไฟล", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize, fontWeight: FontWeight.w200)),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}