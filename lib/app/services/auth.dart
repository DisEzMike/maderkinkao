import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

/// The scopes required by this application.
// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  'profile'
];


final googleSignIn = GoogleSignIn(
  scopes: scopes,
);
// #enddocregion Initialize

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  // #docregion SignIn
  // #enddocregion SignIn

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  // #docregion RequestScopes

Future<bool> handleSignOut() async {
    bool isAuth = false;
    await googleSignIn.disconnect();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAuth = prefs.getBool('auth') ?? false;

    prefs.setBool('auth', false);
    prefs.setString('userId', "");

    return !isAuth;
}

Future<dynamic> getUser(String userId) async {
  FirebaseFirestore database = FirebaseFirestore.instance;
  CollectionReference ref = database.collection('users');
  try {
    dynamic snapshot = await ref.doc(userId).get();
    dynamic data = snapshot.data();
    return User(id: snapshot.id, email: data['email'], photoUrl: data['photoUrl'], displayName: data['displayName'], role: data['role']);
  } catch (e) {
    print("object");
    print(e);
  }
  return null;
}

