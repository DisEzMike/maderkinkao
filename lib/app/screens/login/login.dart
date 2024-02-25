import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

const List<String> scopes = <String>[
  'email',
  'profile',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId: '505215768892-np8i3s0gf0i3htp3br7ubecok2bhkou9.apps.googleusercontent.com',
  scopes: scopes,
);

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((account) async {
      bool isAuthorized = account != null;

      if (kIsWeb && isAuthorized) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // _googleSignIn.signInSilently();
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isAuthorized) ...[Text("Account : ${_currentUser?.displayName}"), ElevatedButton(onPressed: _handleSignOut, child: Text("Sign out"))]
            else ElevatedButton(onPressed: _handleSignIn, child: Text("Sign in")),
            Text("isAuthorized : ${_isAuthorized.toString()}"),
          ],
        ),
      ),
    );
  }
}