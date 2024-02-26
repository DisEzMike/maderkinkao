// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maderkinkao/app/utils/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAEHL_mYymunWMRTL0Af4OKilCgg2squxo",
      authDomain: "marderkinjao.firebaseapp.com",
      projectId: "marderkinjao",
      storageBucket: "marderkinjao.appspot.com",
      messagingSenderId: "505215768892",
      appId: "1:505215768892:web:f0777990ed687cd57c6639",
      measurementId: "G-6652QRP5TM"
    )
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Maderkinkao",
      theme: ThemeData(
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange.shade500, primary: Colors.deepOrange.shade500) ,
        textTheme: GoogleFonts.kanitTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        ),
      ),
      routerConfig: AppRoutes.routes,
    );
  }
}
