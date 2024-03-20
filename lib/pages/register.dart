import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:SecLab/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

double textSize = 20;

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final myControllerMail = TextEditingController();
  final myControllerPW1 = TextEditingController();
  final myControllerPW2 = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void registerSubmit() async {
    if (myControllerPW1.text.length < 8) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Unesite validnu lozinku (min 8 karaktera)'),
            );
          });
    } else {
      if (myControllerPW1.text != myControllerPW2.text) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Lozinke se ne slažu'),
              );
            });
      } else {
        //final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(myControllerMail.text);
          try {
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: myControllerMail.text,
              password: myControllerPW1.text,
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', myControllerMail.text);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RegisterPage2(
                            email: myControllerMail.text)));

          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Ukucana šifra nije dovoljno jaka'),
                    );
                  });
            } else if (e.code == 'email-already-in-use') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Na upisanom e-mail-u je već registrovan profil'),
                    );
                  });
            } else if (e.code == 'invalid-email') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Format e-mail-a nije dobar'),
                    );
                  });
            }
          } catch (e) {
            print(e);
          }
      }
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
              'Registracija - Korak 1/2',
              style: TextStyle(
                color: Colors.yellow[700],
                fontSize: textSize,
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
                    'Upišite Vašu e-mail adresu:',
                    style: TextStyle(
                      fontSize: textSize,
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
                  Text(
                    'Izaberite lozinku za profil:',
                    style: TextStyle(
                      fontSize: textSize,
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
                      controller: myControllerPW1,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.indigo.shade700,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'password (min 8 char.)',

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ponovo upišite lozinku:',
                    style: TextStyle(
                      fontSize: textSize,
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
                      controller: myControllerPW2,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.indigo.shade700,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'repeat password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  ElevatedButton(
                      onPressed: () => registerSubmit(),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 50),
                          backgroundColor: Colors.indigo.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          )),
                      child: Text(
                        'Dalje',
                        style: TextStyle(
                            fontSize: textSize,
                            color: Colors.yellow.shade700,
                            fontWeight: FontWeight.bold),
                      ))
                ]),
          ),
        ));
  }
}

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key, required this.email});

  final String email;

  @override
  State<RegisterPage2> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage2> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final myController = TextEditingController();

  int imageId = 1;

  Map<String, double> sizes = {
    "img1": 30,
    "img2": 40,
    "img3": 40,
    "img4": 40,
    "img5": 40,
    "img6": 40,
    "img7": 40,
    "img8": 40,
  };

  void changeSelection(int id) {
    setState(() {
      sizes.updateAll((key, value) => value = 40);
      sizes["img$id"] = 30;
      imageId = id;
    });
  }

  Future<bool> checkUsername() async {
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        if(doc.get('username') == myController.text){
          return false;
        }
      }
      return true;
    });
    return true;
}

  void registerSubmit() async {
    if (myController.text != '') {
      if (myController.text.length > 3) {
        bool userCheck = await checkUsername();
        if(userCheck == false) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Korisničko ime već postoji'),
                );
              });
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', myController.text);
          prefs.setInt('imageId', imageId);
          prefs.setInt('points', 0);
          prefs.setInt('currentLvl', 1);

          var userAdmin = <String, dynamic>{
            "username": myController.text,
            "email": widget.email,
            "image": imageId,
            "points": 0,
            "level": 1,
            "task1" : <String, dynamic>{
              "isOpen" : true,
              "dateDone" : DateTime.utc(2000,0,0,0,0,0)
            },
            "task2" : <String, dynamic>{
              "isOpen" : true,
              "counter" : 0,
              "dateDone" : DateTime.utc(2000,0,0,0,0,0)
            },
            "task3" : <String, dynamic>{
              "isOpen" : true,
              "counter" : 0,
              "dateDone" : DateTime.utc(2000,0,0,0,0,0)
            },
            "stats" : <String, dynamic>{
              "basicSecurity" : 0,
              "cyberAttack" : 0,
              "encription" : 0,
              "malware" : 0,
              "password" : 0,
              "phishing" : 0,
              "socialEng" : 0,
              "www" : 0,
            },
            
          };

          db.collection("users").doc(widget.email).set(userAdmin);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(
                        username: myController.text,
                        imageId: imageId,
                        bonusCoins: 0,
                      )));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Korisničko ime mora imati bar 4 karaktera'),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Unesite korisničko ime'),
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
            'Registracija - Korak 2/2',
            style: TextStyle(
              color: Colors.yellow[700],
              fontSize: textSize,
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
                'Izaberite korisničko ime:',
                style: TextStyle(
                  fontSize: textSize,
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
                  controller: myController,
                  decoration: InputDecoration(
                    fillColor: Colors.indigo.shade700,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'username',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Izaberite profilnu sliku:',
                style: TextStyle(
                  fontSize: textSize,
                  color: Colors.yellow.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => changeSelection(1),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img1"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser1.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeSelection(2),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img2"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser2.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeSelection(3),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img3"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser3.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeSelection(4),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img4"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser4.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => changeSelection(5),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img5"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser5.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeSelection(6),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img6"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser6.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeSelection(7),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img7"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser7.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeSelection(8),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: sizes["img8"],
                        backgroundImage: AssetImage(
                            'assets/images/profile_pics/AssetUser8.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  onPressed: () => registerSubmit(),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      backgroundColor: Colors.indigo.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                  child: Text(
                    'Dalje',
                    style: TextStyle(
                        fontSize: textSize,
                        color: Colors.yellow.shade700,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
