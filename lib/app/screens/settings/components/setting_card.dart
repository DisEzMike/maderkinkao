import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/utils/constants.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.icon, required this.title, required this.path, required this.active});

  final IconData icon;
  final String title;
  final dynamic path;
  final bool active;

  @override
  Widget build(BuildContext context) {
    double profileHeight = 60;
    return Column(
      children: [
        const SizedBox(height: kDefaultPadding/1.5),
        GestureDetector(
          onTap: active ? () => context.push(path) : null,
          child: SizedBox(
            height: profileHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: active ? Colors.white : Colors.grey.shade200,
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
                    Expanded(flex: 1,child: Icon(icon, size: 20,)),
                    Expanded(flex: 4,child: Text("$title", style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.3)),)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}