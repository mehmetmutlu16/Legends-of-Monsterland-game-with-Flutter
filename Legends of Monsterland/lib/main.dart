import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/changePage.dart';
import 'package:get/get.dart';
import 'package:pokedex/language.dart';
import 'login/loginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int seciliIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: language(),
      locale: Get.locale == null ? Get.deviceLocale : Get.locale,
      fallbackLocale: language.varsayilan,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return changePage();
            } else {
              return AuthScreen();
            }
          }
        },
      ),
    );
  }
}

