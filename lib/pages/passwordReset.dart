import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:SecLab/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final myControllerMail = TextEditingController();

  void SendPasswordReset() async {

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: myControllerMail.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('E-mail poslat, vraćanje na početnu stranicu'),
            );
          });

      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/intro');
      });
    } on FirebaseAuthException catch (e) {
      print(e);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Korisnik ne postoji'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        elevation: 0.0,
        title: Center(
          child: Text(
            'Zahtev za novu lozinku',
            style: TextStyle(
              color: Colors.yellow[700],
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Upišite Vašu e-mail adresu za obnovu lozinke:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: myControllerMail,
                decoration: InputDecoration(
                  fillColor: Colors.indigo.shade700,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: 'e-mail',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => SendPasswordReset(),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    backgroundColor: Colors.indigo.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
                child: Text(
                  'Pošalji',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.yellow.shade700,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      )),
    );
  }
}
