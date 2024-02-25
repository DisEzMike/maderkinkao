// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/cart.dart';
import '../screens/home/main_screen.dart';
import '../screens/login/login.dart';
import '../screens/shop/cart.dart';
import '../screens/shop/menu_detail.dart';
import '../screens/shop/shop.dart';



class AppRoutes {

  static final GoRouter routes = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const MyMainScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLoginPage(),
      ),
      GoRoute(
        path: '/shop/:shopId',
        builder: (context, state) => MyShopScreen(id: state.pathParameters['shopId']),
        routes: [
          GoRoute(
            path: ":menuId",
            pageBuilder:(context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: MenuDetail(id: state.pathParameters['menuId']),
            transitionsBuilder:(context, animation, secondaryAnimation, child) => SlideTransition(position: Tween<Offset>(begin: const Offset(0,1), end: Offset.zero).animate(animation), child: child,),
            ),
          ),
        ]
        ),
        GoRoute(
            path: "/cart",
            pageBuilder:(context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: MyCart(items: state.extra as List<Cart>),
            transitionsBuilder:(context, animation, secondaryAnimation, child) => SlideTransition(position: Tween<Offset>(begin: const Offset(0,1), end: Offset.zero).animate(animation), child: child,),
            ),
          )
    ],
  );
}
