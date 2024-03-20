import 'package:flutter/material.dart';
import 'package:SecLab/levels/level1.dart';
import 'package:SecLab/levels/level10.dart';
import 'package:SecLab/levels/level2.dart';
import 'package:SecLab/levels/level3.dart';
import 'package:SecLab/levels/level4.dart';
import 'package:SecLab/levels/level5.dart';
import 'package:SecLab/levels/level6.dart';
import 'package:SecLab/levels/level7.dart';
import 'package:SecLab/levels/level8.dart';
import 'package:SecLab/levels/level9.dart';
import 'package:SecLab/levels/lvlLoading.dart';
import 'package:shared_preferences/shared_preferences.dart';

int currentLvl = 1;

class LevelMap extends StatefulWidget {
  const LevelMap({super.key});

  @override
  State<LevelMap> createState() => _LevelMapState();
}

class _LevelMapState extends State<LevelMap> {
  void CheckLvl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentLvl = prefs.getInt('currentLvl') ?? 1;
      print('Current lvl ' + currentLvl.toString());
    });
  }

  @override
  void initState() {
    CheckLvl();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 3,
          children: [
            LevelBubble(
              lvl: 1,
              lvlName: 'Uvod 1. deo',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (10).png',
              lvlWidget: LevelLoading(
                levelWidget: Level1(),
              ),
            ),
            LevelBubble(
              lvl: 2,
              lvlName: 'Uvod 2. deo',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (10).png',
              lvlWidget: LevelLoading(
                levelWidget: Level2(),
              ),
            ),
            LevelBubble(
              lvl: 3,
              lvlName: 'Šifre',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (3).png',
              lvlWidget: LevelLoading(
                levelWidget: Level3(currentStep: 0, levelIndex: 0,),
              ),
            ),
            LevelBubble(
              lvl: 4,
              lvlName: 'Phishing',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (15).png',
              lvlWidget: LevelLoading(
                levelWidget: Level4(),
              ),
            ),
            LevelBubble(
              lvl: 5,
              lvlName: 'Socijalni Inženjering',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (12).png',
              lvlWidget: LevelLoading(
                levelWidget: Level5(),
              ),
            ),
            LevelBubble(
              lvl: 6,
              lvlName: 'Enkripcija',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (21).png',
              lvlWidget: LevelLoading(
                levelWidget: Level6(currentStep: 0, levelIndex: 0,),
              ),
            ),
            LevelBubble(
              lvl: 7,
              lvlName: 'Malware',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (17).png',
              lvlWidget: LevelLoading(
                levelWidget: Level7(currentStep: 0, levelIndex: 0, bonusPoints: 0,),
              ),
            ),
            LevelBubble(
              lvl: 8,
              lvlName: 'Primeri u svetu',
              lvlImage:
                  'assets/images/level_icons/ikonice-2 (9).png',
              lvlWidget: LevelLoading(
                levelWidget: Level8(),
              ),
            ),
            LevelBubble(
              lvl: 9,
              lvlName: 'Sajber napad',
              lvlImage:
              'assets/images/level_icons/ikonice-2 (8).png',
              lvlWidget: LevelLoading(
                levelWidget: Level9(),
              ),
            ),
            LevelBubble(
              lvl: 10,
              lvlName: 'Ponavljanje',
              lvlImage:
              'assets/images/level_icons/ikonice-2 (14).png',
              lvlWidget: LevelLoading(
                levelWidget: Level10(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class LevelBubble extends StatefulWidget {
  const LevelBubble(
      {super.key,
      required this.lvl,
      required this.lvlName,
      required this.lvlImage,
      required this.lvlWidget});

  final int lvl;
  final String lvlName;
  final String lvlImage;
  final Widget lvlWidget;

  @override
  State<LevelBubble> createState() => _LevelBubbleState();
}

class _LevelBubbleState extends State<LevelBubble> {
  String completed = '';
  Icon icon = Icon(
    Icons.lock_outline,
    color: Colors.white,
  );
  LinearGradient color =
      LinearGradient(colors: [Colors.indigo.shade400, Colors.indigo.shade800]);

  bool unlocked = false;

  void checkLvlState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int lvl = prefs.getInt('currentLvl') ?? 1;
      if (lvl >= widget.lvl) {
        unlocked = true;
      }
      if (unlocked) {
        completed = 'ODRAĐENO';
        icon = Icon(
          Icons.play_circle_outlined,
          color: Colors.white,
        );
        color =
            LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade800]);
        if (currentLvl == widget.lvl) {
          completed = '';
          color = LinearGradient(
              colors: [Colors.green.shade400, Colors.green.shade800]);
        }
      }

    });
  }

  @override
  void initState() {
    checkLvlState();


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Image.asset(
                  widget.lvlImage,
                  height: 90,
                  width: 90,
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nivo ${widget.lvl}',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.yellow.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.lvlName,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      completed,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.yellow.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                  iconSize: 70,
                  onPressed: () => {
                        if (unlocked)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => widget.lvlWidget))
                      },
                  icon: icon),
            )
          ],
        ),
      ),
    );
  }
}
