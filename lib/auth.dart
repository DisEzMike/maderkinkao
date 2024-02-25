// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// const List<String> scopes = <String>[
//   'email',
//   // 'https://www.googleapis.com/auth/contacts.readonly',
// ];

// final GoogleSignIn googleSignIn = GoogleSignIn(
//     clientId:
//         '505215768892-np8i3s0gf0i3htp3br7ubecok2bhkou9.apps.googleusercontent.com',
//     scopes: scopes);
// String? userEmail, imageUrl;

// Future<bool> isAuth() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getBool("auth") ?? false;
// }

// Future<User?> signInWithGoogle() async {
//   await Firebase.initializeApp();

//   User? user;

//   // onCurrentUserChanged();

//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

//     //   try {
//     //   await googleSignIn.signIn();
//     // } catch (error) {
//     //   print(error);
//     // }

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken:  googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken
//       );

//       try {
//         final UserCredential userCredential = await _auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         print(e.code.split("-").join(" "));
//       } catch (e) {
//         print(e);
//       }
//     }

//     if (user != null) {
//       uid = user.uid;
//       name = user.displayName;
//       userEmail = user.email;
//       imageUrl = user.photoURL;

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool('auth', true);
//     }
//   }

// void signOutGoogle() async {
//   await googleSignIn.signOut();
//   await _auth.signOut();

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool('auth', false);

//   uid = null;
//   name = null;
//   userEmail = null;
//   imageUrl = null;

//   print("User signed out of Google account");
// }

// final FirebaseAuth _auth = FirebaseAuth.instance;

// String? uid;
// String? name;

// Future<User?> registerWithEmailPassword(String email, String password) async {
//   await Firebase.initializeApp();
//   User? user;

//   try {
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);

//     user = userCredential.user;
//     if (user != null) {
//       uid = user.uid;
//       userEmail = user.email;
//     }
//   } on FirebaseAuthException catch (e) {
//     print(e.code);
//   } catch (e) {
//     print(e);
//   }
//   return user;
// }

// Future<User?> signInWithEmailPassword(String email, String password) async {
//   await Firebase.initializeApp();
//   User? user;

//   try {
//     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);

//     user = userCredential.user;
//     if (user != null) {
//       uid = user.uid;
//       userEmail = user.email;

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('auth', true);
//     }
//   } on FirebaseAuthException catch (e) {
//     print(e.code);
//   } catch (e) {
//     print(e);
//   }
//   return user;
// }

// Future<String> signOut() async {
//   await _auth.signOut();

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool('auth', false);

//   uid = null;
//   name = null;
//   userEmail = null;
//   imageUrl = null;

//   return 'User signed out';
// }

// Future getUser() async {
//   await Firebase.initializeApp();

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool authSignedIn = prefs.getBool('auth') ?? false;

//   final User? user = _auth.currentUser;

//   if (authSignedIn == true) {
//     if (user != null) {
//       uid = user.uid;
//       name = user.displayName;
//       userEmail = user.email;
//       imageUrl = user.photoURL;
//     }
//   }
// }

// void onCurrentUserChanged() async {
//   GoogleSignInAccount? currentUser;
//   googleSignIn.onCurrentUserChanged.listen((account) async {
//     bool isAuthorized = account != null;

//     if (kIsWeb && account != null) {
//       isAuthorized = await googleSignIn.canAccessScopes(scopes);
//       currentUser = account;
//     }
//   });
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/models/user.dart';

/// The scopes required by this application.
// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  'profile'
  // 'https://www.googleapis.com/auth/contacts.readonly',
];


final googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
// #enddocregion Initialize

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  // #docregion SignIn
  Future<void> handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
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

Future<User> getUser(String userId) async {
  FirebaseFirestore database = FirebaseFirestore.instance;
  CollectionReference ref = database.collection('users');
  DocumentSnapshot snapshot = await ref.doc(userId).get();
  return User(uid: snapshot.get('uid'), email: snapshot.get('email'), photoUrl: snapshot.get('photoUrl'), displayName: snapshot.get('displayName'), role: snapshot.get('role'));
}

