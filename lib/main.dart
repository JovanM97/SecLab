import 'package:SecLab/pages/passwordReset.dart';
import 'package:flutter/material.dart';
import 'package:SecLab/firebase_options.dart';
import 'package:SecLab/pages/intro.dart';
import 'pages/loading.dart';
import 'pages/loading.dart';
import 'pages/register.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: 'seclab-bd25b',options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(), //HomePage(username: 'Jovan', imageId: 1, bonusCoins: 4000)
      '/register': (context) => RegisterPage1(),
      '/intro': (context) => IntroPage(),
      '/resetPw': (context) => PasswordResetPage(),
    },
  ));
}
