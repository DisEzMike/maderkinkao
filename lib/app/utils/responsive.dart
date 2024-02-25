import 'package:flutter/material.dart';

import 'constants.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < maxWidthMobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < maxWidthTablet &&
      MediaQuery.of(context).size.width >= maxWidthMobile;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= maxWidthTablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than maxWidthTablet then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= maxWidthTablet) {
          return desktop;
        }
        // If width it less then maxWidthTablet and more then maxWidthMobile we consider it as tablet
        else if (constraints.maxWidth >= maxWidthMobile) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
