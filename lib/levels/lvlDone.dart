import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';

class LvlDone extends StatefulWidget {
  const LvlDone(
      {super.key,
      required this.levelPoints,
      required this.totalQuestions,
      required this.correctQuestions,
      required this.lvlId,
      required this.minigamesDone,
        required this.statsLocation});

  final int totalQuestions;
  final int correctQuestions;
  final int levelPoints;
  final int lvlId;
  final int minigamesDone;
  final String statsLocation;

  @override
  State<LvlDone> createState() => _LvlDoneState();
}

class _LvlDoneState extends State<LvlDone> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool task1Open = true;
  bool task2Open = true;
  bool task3Open = true;

  int task2Counter = 0;
  int task3Counter = 0;

  String email = "";

  int finalPoints = 0;

  void returnToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username').toString();
    email = prefs.getString('email').toString();
    int imageId = prefs.getInt('imageId') ?? 1;
    int points = prefs.getInt('points') ?? 0;
    int currentLvl = prefs.getInt('currentLvl') ?? 1;
    if (currentLvl == widget.lvlId) {
      prefs.setInt('currentLvl', (++currentLvl));
    }

    db.collection("users").doc(email).update({'level': currentLvl});

    finalPoints = widget.levelPoints;

    final doc = await db.collection("users").doc(email);
    await doc.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> task1 = data["task1"] as Map<String, dynamic>;
        Map<String, dynamic> task2 = data["task2"] as Map<String, dynamic>;
        Map<String, dynamic> task3 = data["task3"] as Map<String, dynamic>;
        Map<String, dynamic> stats = data["stats"] as Map<String, dynamic>;

        task1Open = task1['isOpen'];
        task2Open = task2['isOpen'];
        task3Open = task3['isOpen'];

        task2Counter = task2['counter'];
        task3Counter = task3['counter'];

        if(widget.statsLocation != ''){
          int statPoints = stats['${widget.statsLocation}'];
          db.collection("users").doc(email).update({'stats.${widget.statsLocation}': (statPoints+widget.correctQuestions)});
        }
        int statBasicSecPoints = stats['basicSecurity'];
        db.collection("users").doc(email).update({'stats.basicSecurity': (statBasicSecPoints+widget.correctQuestions)});

        checkTaskInfo();
      }
    );

    points += finalPoints;

    prefs.setInt('points', points);
    db.collection("users").doc(email).update({'points': points});

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  username: username,
                  imageId: imageId,
                  bonusCoins: finalPoints,
                )));
  }

  void checkTaskInfo() async {
    if (task1Open) {
      db.collection("users").doc(email).update({'task1.isOpen': false});
      db.collection("users").doc(email).update({'task1.dateDone': DateTime.now()});
      finalPoints += 50;
    }
    if (task2Open) {
      if ((task2Counter + widget.minigamesDone) >= 2) {
        db.collection("users").doc(email).update({'task2.isOpen': false});
        db.collection("users").doc(email).update({'task2.counter': 0});
        db.collection("users").doc(email).update({'task2.dateDone': DateTime.now()});
        finalPoints += 100;
      }
      else {
        db.collection("users").doc(email).update({'task2.counter': (task2Counter + widget.minigamesDone)});
      }
    }
    if (task3Open) {
      if ((task3Counter + widget.correctQuestions) >= 10) {
        db.collection("users").doc(email).update({'task3.isOpen': false});
        db.collection("users").doc(email).update({'task3.counter': 0});
        db.collection("users").doc(email).update({'task3.dateDone': DateTime.now()});
        finalPoints += 150;
      }
      else {
        db.collection("users").doc(email).update({'task3.counter': (task3Counter + widget.correctQuestions)});
      }
    }
  }

  late ConfettiController _controllerCenter;

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
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
          child: Animate(
            effects: [
              ScaleEffect(duration: 300.ms),
              FadeEffect(duration: 300.ms)
            ],
            child: Container(
              height: 400,
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.indigo.shade700,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConfettiWidget(
                      confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    createParticlePath: drawStar, // manually spec
                  ),
                  Text(
                    'Čestitamo!',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.yellow.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Uspešnost: ',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${widget.correctQuestions}/${widget.totalQuestions}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Osvojeni bodovi: ',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${widget.levelPoints}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () => returnToHome(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade700,
                          fixedSize: Size(200, 60)),
                      child: Text(
                        'Početna',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
