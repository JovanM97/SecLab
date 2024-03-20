import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Badges extends StatefulWidget {
  const Badges({super.key});

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  int badgeLimit = 50;
  int badgeBiggerLimit = 150;

  int basicSecurity = 0;
  int cyberAttack = 0;
  int encription = 0;
  int malware = 0;
  int password = 0;
  int phishing = 0;
  int socialEng = 0;
  int www = 0;
  int cyberExpert = 0;

  String badge1 = 'assets/images/badges/Asset 61x Lock.png';
  String badge2 = 'assets/images/badges/Asset 151x Lock.png';
  String badge3 = 'assets/images/badges/Asset 71x Lock.png';
  String badge4 = 'assets/images/badges/Asset 121x Lock.png';
  String badge5 = 'assets/images/badges/Asset 131x Lock.png';
  String badge6 = 'assets/images/badges/Asset 91x Lock.png';
  String badge7 = 'assets/images/badges/Asset 141x Lock.png';
  String badge8 = 'assets/images/badges/Asset 31x Lock.png';
  String badge9 = 'assets/images/badges/Asset 101x Lock.png';

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getBadgeStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email').toString();

    final doc = await db.collection("users").doc(email);
    await doc.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      Map<String, dynamic> stats = data["stats"] as Map<String, dynamic>;

      basicSecurity = stats['basicSecurity'];
      cyberAttack = stats['cyberAttack'];
      encription = stats['encription'];
      malware = stats['malware'];
      password = stats['password'];
      phishing = stats['phishing'];
      socialEng = stats['socialEng'];
      www = stats['www'];

      checkStats();
    });
  }

  void checkStats() {
    ///CHECK STATS AND SET CORRECT SPRITES
    if (basicSecurity >= badgeBiggerLimit) {
      basicSecurity = badgeBiggerLimit;
      cyberExpert++;
      badge3 = 'assets/images/badges/Asset 71x.png';
    }
    if (cyberAttack >= badgeLimit) {
      cyberAttack = badgeLimit;
      cyberExpert++;
      badge9 = 'assets/images/badges/Asset 101x.png';
    }
    if (encription >= badgeLimit) {
      encription = badgeLimit;
      cyberExpert++;
      badge6 = 'assets/images/badges/Asset 91x.png';
    }
    if (malware >= badgeLimit) {
      malware = badgeLimit;
      cyberExpert++;
      badge8 = 'assets/images/badges/Asset 31x.png';
    }
    if (password >= badgeLimit) {
      password = badgeLimit;
      cyberExpert++;
      badge1 = 'assets/images/badges/Asset 61x.png';
    }
    if (phishing >= badgeLimit) {
      phishing = badgeLimit;
      cyberExpert++;
      badge2 = 'assets/images/badges/Asset 151x.png';
    }
    if (socialEng >= badgeLimit) {
      socialEng = badgeLimit;
      cyberExpert++;
      badge5 = 'assets/images/badges/Asset 131x.png';
    }
    if (www >= badgeLimit) {
      www = badgeLimit;
      cyberExpert++;
      badge7 = 'assets/images/badges/Asset 141x.png';
    }
    if(cyberExpert >= 9) {
      cyberExpert = 9;
      badge4 = 'assets/images/badges/Asset 121x.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getBadgeStats(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'BEDŽEVI',
                        style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BadgeImage(
                              imageSrc: badge1,
                              badgeName: 'Password Expertise',
                              badgeDescription:
                                  'Dobro znanje vezano za šifre i lozinke',
                              counter: password.toDouble(),
                              limit: badgeLimit.toDouble()),
                          BadgeImage(
                              imageSrc: badge2,
                              badgeName: 'Phishing Master',
                              badgeDescription: 'Dobro znanje o phishing-u',
                              counter: phishing.toDouble(),
                              limit: badgeLimit.toDouble()),
                          BadgeImage(
                              imageSrc: badge3,
                              badgeName: 'Basic Security Knowlegde',
                              badgeDescription:
                                  'Dobro znanje o opštoj sajber bezbednosti',
                              counter: basicSecurity.toDouble(),
                              limit: badgeBiggerLimit.toDouble())
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BadgeImage(
                              imageSrc: badge4,
                              badgeName: 'Security Expertice',
                              badgeDescription:
                                  'Dobro znanje o svim pojmovima sajber bezbednosti (Svi ostali bedževi otključani)',
                              counter: cyberExpert.toDouble(),
                              limit: 8),
                          BadgeImage(
                              imageSrc: badge5,
                              badgeName: 'Social Engineering Master',
                              badgeDescription:
                                  'Dobro znanje o socijalnom inženjeringu',
                              counter: socialEng.toDouble(),
                              limit: badgeLimit.toDouble()),
                          BadgeImage(
                              imageSrc: badge6,
                              badgeName: 'Encription Expertise',
                              badgeDescription:
                                  'Dobro znanje o enkripciji i dekripciji podataka',
                              counter: encription.toDouble(),
                              limit: badgeLimit.toDouble())
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BadgeImage(
                              imageSrc: badge7,
                              badgeName: 'World Wide Wisdom',
                              badgeDescription:
                                  'Dobro znanje o primerima sajber bezbednosti u svetu',
                              counter: www.toDouble(),
                              limit: badgeLimit.toDouble()),
                          BadgeImage(
                              imageSrc: badge8,
                              badgeName: 'Malwer Security',
                              badgeDescription: 'Dobro znanje o malwer-ima',
                              counter: malware.toDouble(),
                              limit: badgeLimit.toDouble()),
                          BadgeImage(
                              imageSrc: badge9,
                              badgeName: 'Cyber Attack Experience',
                              badgeDescription:
                                  'Dobro znanje o sajber napadima',
                              counter: cyberAttack.toDouble(),
                              limit: badgeLimit.toDouble())
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.indigo.shade900,
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'BEDŽEVI',
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SpinKitRing(
                      color: Colors.yellow.shade700,
                      size: 80,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class BadgeImage extends StatefulWidget {
  const BadgeImage(
      {super.key,
      required this.imageSrc,
      required this.badgeName,
      required this.badgeDescription,
      required this.counter,
      required this.limit});

  final String imageSrc;
  final String badgeName;
  final String badgeDescription;
  final double counter;
  final double limit;

  @override
  State<BadgeImage> createState() => _BadgeImageState();
}

class _BadgeImageState extends State<BadgeImage> {
  double getProgressBarValue() {
    if (widget.counter == 0)
      return 0.0;
    else
      return (widget.counter / widget.limit);
  }

  void showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.indigo.shade700,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              height: 200, //MediaQuery.of(context).size.height/4,
              width: 300, //MediaQuery.of(context).size.width/1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.badgeName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.yellow.shade700,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.badgeDescription,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.yellow.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  LinearProgressIndicator(
                    color: Colors.yellow.shade700,
                    backgroundColor: Colors.indigo.shade200,
                    value: widget.counter / widget.limit,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.counter.toInt()}/${widget.limit.toInt()}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.yellow.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCustomDialog(context),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 40.0,
        child: CircleAvatar(
          backgroundColor: Colors.yellow[700],
          radius: 38.0,
          backgroundImage: AssetImage(widget.imageSrc),
        ),
      ),
    );
  }
}
