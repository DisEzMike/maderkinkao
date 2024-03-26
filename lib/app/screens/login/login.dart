// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/components/loading.dart';
import 'package:maderkinkao/app/models/user.dart';
import 'package:maderkinkao/app/utils/authentication.dart';
import 'package:maderkinkao/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/sign_button.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: MyLoginPage(),
    ),
  );
}

/// The MyLoginPage app.
class MyLoginPage extends StatefulWidget {
  ///
  const MyLoginPage({super.key});

  @override
  State createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _isLoading = false;
  String error = "";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: buildBody(),
        ));
  }

void _handdleSignInWithGoogle() async {
  setState(() {
    _isLoading = true;
  });
  try {
    var account = await Authentication.signInWithGoogle();

    bool isAuthorized = account != null;
    if (account != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', isAuthorized);

      User user = User(email: account.email, photoUrl: account.photoURL, displayName: account.displayName);
      FirebaseFirestore database = FirebaseFirestore.instance;
      CollectionReference ref = database.collection('users');
      ref.where("email", isEqualTo: user.email!).get().then((value) => value.docs).then((value) async {
        if (value.isNotEmpty) {
          await prefs.setString('userId', value[0].id);
        } else {
          dynamic data = user.toJson();
          data['role'] = ['user'];
          try {
            final dRef = await ref.add(data);
            data['id'] = dRef.id;
            await ref.doc(dRef.id).update(data);
            await prefs.setString('userId', dRef.id);

            print(data);
          } catch (e) {
            print(e);
          }
        }
      });
    }
    
    if (isAuthorized) {
      context.pushReplacement('/home');
    }
  } catch (e) {
    setState(() {
      _isLoading = false;
      error = "มีปัญหาในการเข้าสู้ระบบโปรลองอีกครั้ง";
    });
  }
}

  Widget buildBody() {
    return Center(
    child: _isLoading ? const Loading() : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignInButton(
          buttonType: ButtonType.google,
          onPressed: _handdleSignInWithGoogle),
          // ...[
          //   const SizedBox(height: kDefaultPadding),
          //   SignInButton(
          //     buttonType: ButtonType.googleDark,
          //     btnText: "Developer mode",
          //     onPressed: _handdleToDevMode
          //   )
          // ],
          ...[
            const SizedBox(height: kDefaultPadding),
            Text("$error",style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: kDefaultFontSize*1.2, color: Colors.red)),)
          ]
      ],
    ),
  );
}

  void _handdleToDevMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
    prefs.setString('userId', "U6JSoJYVVvXqpf4IdqtPCXy1GN92");
    context.pushReplacement('/home');
  }

  void test() {
    FirebaseFirestore.instance.collection('shops').doc('1').collection('orders').orderBy('queue', descending: false).get().then((docs) {
      var data = docs.docs.map((e) => [e.data()['queue'], (e.data()['createdAt'] as Timestamp).toDate()]);
      print(data);
    });
  }
}