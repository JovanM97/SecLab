import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:SecLab/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void delayLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove('email');

    ///AUTO LOGIN
    if (false) { //prefs.containsKey('email')
      if (prefs.getString('email') != '') {
        String username = prefs.getString('username').toString();
        String email = prefs.getString('email').toString();
        String pw = prefs.getString('pw').toString();
        int imageId = prefs.getInt('imageId') ?? 1;
        int points = prefs.getInt('points') ?? 0;

        try {
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: pw
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                    username: username,
                    imageId: imageId,
                    bonusCoins: points,
                  )));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Navigator.pushReplacementNamed(context, '/intro');
          } else if (e.code == 'wrong-password') {
            Navigator.pushReplacementNamed(context, '/intro');
          }
        }
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, '/intro');
        });
      }
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/intro');
      });
    }
  }

  @override
  void initState() {
    delayLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Center(
        child: SpinKitRing(
          color: Colors.yellow.shade700,
          size: 80,
        ),
      ),
    );
  }
}
