// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maderkinkao/app/components/loading.dart';
import 'package:maderkinkao/app/models/user.dart';
import 'package:maderkinkao/app/utils/authentication.dart';
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
  @override
  void initState() {
    super.initState();

    // googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {

    //   bool isAuthorized = account != null;

    //   if (kIsWeb && account != null) {
    //     isAuthorized = await googleSignIn.canAccessScopes(scopes);

      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   prefs.setBool('auth', isAuthorized);
    
      //   User user = User(uid: account.id, email: account.email, photoUrl: account.photoUrl, displayName: account.displayName);
      //   FirebaseFirestore database = FirebaseFirestore.instance;
      //   CollectionReference ref = database.collection('users');
      //   ref.doc(user.uid).get().then((DocumentSnapshot snapshot) {
      //     if (snapshot.exists) return;
      //     dynamic data = user.toJson();
      //     data['role'] = 'user';
      //     ref.doc(user.uid!).set(data);
      //   });
      //   prefs.setString('userId', user.uid!);
      // }
      // if (isAuthorized) {
      //   context.pushReplacement('/home');
      // }
    // });
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
    var account = await Authentication.signInWithGoogle();

  bool isAuthorized = account != null;
  if (account != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', isAuthorized);

    User user = User(uid: account.uid, email: account.email, photoUrl: account.photoURL, displayName: account.displayName);
    FirebaseFirestore database = FirebaseFirestore.instance;
    CollectionReference ref = database.collection('users');
    ref.doc(user.uid).get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) return;
      dynamic data = user.toJson();
      data['role'] = 'user';
      ref.doc(user.uid!).set(data);
    });
    prefs.setString('userId', user.uid!);
  }
  if (isAuthorized) {
    context.pushReplacement('/home');
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
      ],
    ),
  );
}

  void test() {
    FirebaseFirestore.instance.collection('shops').doc('1').collection('orders').orderBy('queue', descending: false).get().then((docs) {
      var data = docs.docs.map((e) => [e.data()['queue'], (e.data()['createdAt'] as Timestamp).toDate()]);
      print(data);
    });
  }
}