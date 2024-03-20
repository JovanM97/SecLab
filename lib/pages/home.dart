import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'levelmap.dart';
import 'leaderboards.dart';
import 'badges.dart';
import 'tasks.dart';

class HomePage extends StatefulWidget {
  final String username;
  final int imageId;
  final int bonusCoins;

  const HomePage(
      {super.key,
      required this.username,
      required this.imageId,
      required this.bonusCoins});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String username = '';
  int coins = 0;

  String image = 'assets/images/profile_pics/AssetUser3.png';

  int pageIndex = 0;
  List<Widget> pages = [];

  Color? btn1 = Colors.indigo;
  Color? btn2 = Colors.indigo[700];
  Color? btn3 = Colors.indigo[700];
  Color? btn4 = Colors.indigo[700];

  @override
  void initState() {
    pages = [LevelMap(), LeaderBoards(), Tasks(), Badges()];
    username = widget.username;
    image = 'assets/images/profile_pics/AssetUser' +
        widget.imageId.toString() +
        '.png';
    checkCoins();
  }

  void changeActivePage(int index) {
    setState(() {
      pageIndex = index;
      btn1 = Colors.indigo[700];
      btn2 = Colors.indigo[700];
      btn3 = Colors.indigo[700];
      btn4 = Colors.indigo[700];
      switch (index) {
        case 0:
          btn1 = Colors.indigo;
          break;
        case 1:
          btn2 = Colors.indigo;
          break;
        case 2:
          btn3 = Colors.indigo;
          break;
        case 3:
          btn4 = Colors.indigo;
          break;
      }
    });
  }

  void checkCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email').toString();

    final doc = await db.collection("users").doc(email);
    await doc.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        coins = data["points"] ?? 0;
      });
    });
  }

  void showPopupMenu() async {
    showMenu<String>(
      color: Colors.indigo.shade800,
      context: context,
      position: RelativeRect.fromLTRB(25.0, 100.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
          child: Text('Izlogujte se',style: TextStyle(
            color: Colors.yellow[700],
            fontWeight: FontWeight.bold,
          ),),
          value: '1',
          onTap: logOut,
        ),
      ],
      elevation: 8.0,
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('pw');
    prefs.remove('points');
    prefs.remove('imageId');
    prefs.remove('username');

    Navigator.pushReplacementNamed(context, '/intro');
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo[900],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo[800],
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22.0,
                child: CircleAvatar(
                  backgroundColor: Colors.yellow[700],
                  radius: 25.0,
                  backgroundImage: AssetImage(image),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                username,
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                coins.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Icon(
                Icons.monetization_on_sharp,
                color: Colors.yellow[700],
              ),
              SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                child: const Icon(Icons.menu),
                onTapDown: (details) => showPopupMenu(),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 12, child: pages[pageIndex]),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              onPressed: () => changeActivePage(0),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(60, 55),
                                  backgroundColor: btn1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  )),
                              child: Icon(
                                Icons.play_circle_filled,
                                size: 30,
                                color: Colors.yellow.shade700,
                              ))),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () => changeActivePage(1),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(60, 55),
                                backgroundColor: btn2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                )),
                            child: Image.asset(
                              'assets/images/ui/Asset 261x.png',
                              scale: 4,
                              width: 20,
                              height: 20,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () => changeActivePage(2),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(60, 55),
                                backgroundColor: btn3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                )),
                            child: Icon(
                              Icons.playlist_add_check,
                              size: 40,
                              color: Colors.yellow.shade700,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () => changeActivePage(3),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(60, 55),
                                backgroundColor: btn4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                )),
                            child: Image.asset(
                              'assets/images/ui/Asset 281x.png',
                              scale: 1,
                              width: 30,
                              height: 20,
                            )),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
