import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/chat.dart';
import 'package:test/pages/convert_main.dart';
import 'package:test/pages/currency_center.dart';
import 'package:test/pages/profile_setting.dart';
import 'package:test/screens/logout.dart';
import 'package:test/screens/signin_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
      routes: {
        '/convert_main': (context) => ConvertMain(),
        '/chat': (context) => Chat(),
        '/profile_setting': (context) => ProfileSetting(),
        '/currency_center': (context) => CurrencyCenter(
            userID: FirebaseAuth.instance.currentUser?.uid ?? ''),
        '/logout': (context) => Logout(),
      },
    );
  }
}
