import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SecLab/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final myControllerMail = TextEditingController();
  final myControllerPW = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: myControllerMail.text, password: myControllerPW.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', myControllerMail.text);

      final docRef = await db.collection("users").doc(myControllerMail.text);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          prefs.setString('username', data['username']);
          prefs.setInt('imageId', data['image']);
          prefs.setInt('points', data['points']);
          prefs.setInt('currentLvl', data['level']);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        username: data['username'],
                        imageId: data['image'],
                        bonusCoins: data['points'],
                      )));
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Pogrešan e-mail ili šifra'),
              );
            });
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Pogrešan e-mail ili šifra'),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Pogrešan e-mail ili šifra'),
              );
            });
      }
    }
  }

  void goToRegister() async {
    Navigator.pushNamed(context, '/register');
  }

  void goToResetPwPage() async {
    Navigator.pushNamed(context, '/resetPw');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo.shade900,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon/scelab_logo-04.png',
                  width: 200,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 30,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: myControllerPW,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.indigo.shade700,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () => login(),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 50),
                        backgroundColor: Colors.indigo.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        )),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow.shade700,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Text(
                    'Zaboravili ste lozinku?',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow.shade700,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () => goToResetPwPage(),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text(
                    'Nemate profil? Registrujte se ovde',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow.shade700,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () => goToRegister(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
