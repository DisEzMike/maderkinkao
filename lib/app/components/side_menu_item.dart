// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class SideMenuItem extends StatelessWidget {
  SideMenuItem({
    super.key,
    this.isActive = false,
    this.isHover = false,
    this.showBorder = true,
    required this.icons,
    required this.title,
    required this.press,
  });

  bool isActive, isHover, showBorder;
  final String title;
  final List<Icon> icons;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 15, right: 5),
                decoration: showBorder
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFDFE2EF)),
                        ),
                      )
                    : null,
                child: Row(
                  children: [
                    (isActive || isHover) ? icons[1] : icons[0],
                    SizedBox(width: kDefaultPadding * 0.75),
                    Text(
                      title,
                    ),
                    Spacer(),
                    // if (itemCount != null) CounterBadge(count: itemCount)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
