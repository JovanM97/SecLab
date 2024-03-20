import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

int totalSteps = 5;

class Level7 extends StatefulWidget {
  Level7({super.key, required this.currentStep, required this.levelIndex, required this.bonusPoints});

  int currentStep = 0;
  int levelIndex = 0;
  int bonusPoints = 0;

  @override
  State<Level7> createState() => _Level7State();
}

class _Level7State extends State<Level7> {
  List<Widget> levelParts = [];

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
                    'Definicija',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Malware: Skraćenica za zlonamerni softver, odnosi se na bilo koji softver dizajniran da ošteti ili iskorišćava računarske sisteme, uključujući viruse, crve, ransomvare i špijunski softver.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.yellow[700],
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ));

  @override
  void initState() {
    levelParts = [MalwareIntro(), Level7Quiz(bonusPoints: widget.bonusPoints,)];
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
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nivo 7 - Malware',
                  style: TextStyle(
                    color: Colors.yellow[700],
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => showCustomDialog(context),
                  child: Icon(
                    Icons.quiz,
                    color: Colors.yellow[700],
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                levelParts[widget.levelIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MalwareIntro extends StatefulWidget {
  const MalwareIntro({super.key});

  @override
  State<MalwareIntro> createState() => _MalwareIntroState();
}

class _MalwareIntroState extends State<MalwareIntro> {
  bool canAnim = false;
  bool nastavi = false;
  double imageSize = 70;
  int counter = 0;
  int correctAns = 0;
  int points = 0;

  bool showIcon1 = true;
  bool showIcon2 = true;
  bool showIcon3 = true;
  bool showIcon4 = true;
  bool showIcon5 = true;
  bool showIcon6 = true;
  bool showIcon7 = true;
  bool showIcon8 = true;
  bool showIcon9 = true;

  void ContinueLvl() {
    setState(() {
      canAnim = true;
      Future.delayed(Duration(milliseconds: 1500), () {
        //LVL DONE
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Level7(currentStep: 1, levelIndex: 1, bonusPoints: points,)));
      });
    });
  }

  void CheckIcon(int value, int expectedValue) {
    print('Dropped icon');
    if (value == expectedValue) {
      correctAns++;
      if(correctAns > 9) {
        correctAns = 9;
      }
    }
    counter++;
    if (counter >= 9) {
      print('Dropping DONE');
      setState(() {
        points = correctAns*5;
        nastavi = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Prevucite ikonice u odgovarajuća polja',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.yellow[700],
              fontSize: 20,
            )),
        SizedBox(
          height: 10,
        ),
        Animate(
          target: canAnim ? 0 : 1,
          effects: [
            SlideEffect(
                begin: Offset(2, 0),
                end: Offset(0, 0),
                duration: 600.ms,
                delay: 1000.ms)
          ],
          child: Container(
            height: 300,
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.indigo.shade700,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (showIcon1)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon1 = false;
                      }),
                      data: 0,
                      child: Image.asset(
                        'assets/images/malware/bug.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/bug.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon1 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                    if (showIcon2)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon2 = false;
                      }),
                      data: 0,
                      child: Image.asset(
                        'assets/images/malware/hacker.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/hacker.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon2 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                    if (showIcon3)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon3 = false;
                      }),
                      data: 1,
                      child: Image.asset(
                        'assets/images/malware/facebook.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/facebook.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon3 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (showIcon4)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon4 = false;
                      }),
                      data: 0,
                      child: Image.asset(
                        'assets/images/malware/mail.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/mail.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon4 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                    if (showIcon5)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon5 = false;
                      }),
                      data: 1,
                      child: Image.asset(
                        'assets/images/malware/social.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/social.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon5 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                    if (showIcon6)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon6 = false;
                      }),
                      data: 0,
                      child: Image.asset(
                        'assets/images/malware/trojan.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/trojan.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon6 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (showIcon7)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon7 = false;
                      }),
                      data: 1,
                      child: Image.asset(
                        'assets/images/malware/tiktok.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/tiktok.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon7 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                    if (showIcon8)
                    Draggable<int>(
                      onDragCompleted: () => setState(() {
                        showIcon8 = false;
                      }),
                      data: 0,
                      child: Image.asset(
                        'assets/images/malware/virus.png',
                        width: imageSize,
                      ),
                      feedback: Image.asset(
                        'assets/images/malware/virus.png',
                        width: imageSize,
                      ),
                      childWhenDragging: Container(
                        width: imageSize,
                      ),
                    ),
                    if (showIcon8 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                    if (showIcon9)
                      Draggable<int>(
                        onDragCompleted: () => setState(() {
                          showIcon9 = false;
                        }),
                        data: 0,
                        child: Image.asset(
                          'assets/images/malware/virus (1).png',
                          width: imageSize,
                        ),
                        feedback: Image.asset(
                          'assets/images/malware/virus (1).png',
                          width: imageSize,
                        ),
                        childWhenDragging: Container(
                          width: imageSize,
                        ),
                      ),
                    if (showIcon9 == false)
                      Container(
                        width: imageSize,
                        height: imageSize,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Animate(
          target: canAnim ? 0 : 1,
          effects: [
            SlideEffect(
                begin: Offset(2, 0),
                end: Offset(0, 0),
                duration: 600.ms,
                delay: 1000.ms)
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DragTarget<int>(
                onAccept: (data) => CheckIcon(data, 0),
                builder: (context, _, __) => Container(
                  height: 100,
                  width: 160,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red.shade700,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/malware/bin.png',
                      width: 50,
                    ),
                  ),
                ),
              ),
              DragTarget<int>(
                onAccept: (data) => CheckIcon(data, 1),
                builder: (context, _, __) => Container(
                  height: 100,
                  width: 160,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.green.shade700,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/malware/check-mark.png',
                      width: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        if (nastavi)
          Animate(
            effects: [SlideEffect(begin: Offset(0, 1), end: Offset(0, 0))],
            child: Column(
              children: [
                Text('Upešnost $correctAns/9 - $points bodova',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.yellow[700],
                    fontSize: 20,
                  )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => ContinueLvl(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        fixedSize: Size(200, 60)),
                    child: Text(
                      'Dalje',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )),
              ],
            ),
          )
      ],
    );
  }
}

class Level7Quiz extends StatefulWidget {
  Level7Quiz({super.key, required this.bonusPoints});

  int bonusPoints;

  @override
  State<Level7Quiz> createState() => _Level7QuizState();
}

class _Level7QuizState extends State<Level7Quiz> {
  int currentStep = 0;
  int totalQuestions = 4;

  final List<String> questions = [
    'Šta radi malver trojanski konj?',
    'Koji je uobičajen tip malvera koji šifruje datoteke i zahteva otkup za njihovo oslobađanje?',
    'Šta od sledećeg predstavlja potencijalni efekat infekcije malverom?',
    'Koja je svrha špijunskog softvera?'
  ];

  final List<String> answersA = [
    'Obezbeđuje bezbednosna ažuriranja sistema',
    'Antivirusni softver',
    'Povećana brzina sistema',
    'Za prikupljanje osetljivih informacija bez saglasnosti korisnika'
  ];
  final List<String> answersB = [
    'Prerušava se kao legitiman softver da bi prevario korisnike da ga instaliraju, a zatim vrši zlonamerne aktivnosti',
    'Softver za pravljenje rezervnih kopija podataka',
    'Jače šifrovanje podataka',
    'Za zaštitu od virusa'
  ];
  final List<String> answersC = [
    'Poboljšava performanse sistema',
    'Ransomware',
    'Poboljšana mrežna povezanost',
    'Za poboljšanje privatnosti korisnika'
  ];
  final List<String> answersD = [
    'Štiti od phishing napada',
    'Adware',
    'Gubitak ili oštećenje podataka',
    'Za optimizaciju performansi sistema'
  ];
  final List<String> corrects = ['B', 'C', 'D', 'A'];

  Color? colorA;
  Color? colorB;
  Color? colorC;
  Color? colorD;

  bool nastavi = false;
  bool canAnim = false;
  bool canAnswer = true;

  int correctAnswers = 0;

  void CheckAnswer(String btn) {
    if (canAnswer) {
      setState(() {
        canAnswer = false;
        colorA = Colors.red.shade700;
        colorB = Colors.red.shade700;
        colorC = Colors.red.shade700;
        colorD = Colors.red.shade700;

        switch (corrects[currentStep]) {
          case 'A':
            colorA = Colors.green.shade700;
            break;
          case 'B':
            colorB = Colors.green.shade700;
            break;
          case 'C':
            colorC = Colors.green.shade700;
            break;
          case 'D':
            colorD = Colors.green.shade700;
            break;
        }

        if (btn == corrects[currentStep]) {
          correctAnswers++;
        }
        nastavi = true;
      });
    }
  }

  void NextStep() {
    if (currentStep < totalQuestions - 1) {
      setState(() {
        colorA = Colors.yellow.shade700;
        colorB = Colors.yellow.shade700;
        colorC = Colors.yellow.shade700;
        colorD = Colors.yellow.shade700;

        currentStep++;
        nastavi = false;
        canAnim = false;
        canAnswer = true;
      });
    } else {
      int finalPoints = correctAnswers * 15 + widget.bonusPoints;

      ///LEVEL DONE
      correctAnswers++;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LvlDone(
                  levelPoints: finalPoints,
                  totalQuestions: totalSteps,
                  correctQuestions: correctAnswers,
                  lvlId: 7,
                  minigamesDone: 1,
                  statsLocation: 'malware')));
    }
  }

  void AnimLeave() async {
    setState(() {
      canAnim = true;
      Future.delayed(Duration(milliseconds: 1500), () {
        NextStep();
      });
    });
  }

  @override
  void initState() {
    colorA = Colors.yellow.shade700;
    colorB = Colors.yellow.shade700;
    colorC = Colors.yellow.shade700;
    colorD = Colors.yellow.shade700;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 150),
          child: StepProgressIndicator(
            totalSteps: totalSteps,
            currentStep: currentStep + 1,
            padding: 5,
            size: 15,
            selectedColor: Colors.amber,
            unselectedColor: Colors.indigo.shade600,
            customStep: (index, color, _) => color == Colors.green
                ? Container(
              decoration: BoxDecoration(
                  color: color, shape: BoxShape.circle),
            )
                : Container(
              decoration: BoxDecoration(
                  color: color, shape: BoxShape.circle),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.indigo.shade700,
          ),
          child: Center(
            child: Animate(
              target: canAnim ? 0 : 1,
              effects: [FadeEffect(duration: 500.ms)],
              child: Text(
                questions[currentStep],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Animate(
          target: canAnim ? 0 : 1,
          effects: [
            SlideEffect(
                begin: Offset(2, 0),
                end: Offset(0, 0),
                duration: 600.ms,
                delay: 1000.ms)
          ],
          child: AnswerBubble(
            letter: 'A',
            answer: answersA[currentStep],
            backroundColor: colorA,
            checkAnswer: CheckAnswer,
          ),
        ),
        Animate(
          target: canAnim ? 0 : 1,
          effects: [
            SlideEffect(
                begin: Offset(2, 0),
                end: Offset(0, 0),
                duration: 600.ms,
                delay: 1000.ms)
          ],
          child: AnswerBubble(
            letter: 'B',
            answer: answersB[currentStep],
            backroundColor: colorB,
            checkAnswer: CheckAnswer,
          ),
        ),
        Animate(
          target: canAnim ? 0 : 1,
          effects: [
            SlideEffect(
                begin: Offset(2, 0),
                end: Offset(0, 0),
                duration: 600.ms,
                delay: 1000.ms)
          ],
          child: AnswerBubble(
            letter: 'C',
            answer: answersC[currentStep],
            backroundColor: colorC,
            checkAnswer: CheckAnswer,
          ),
        ),
        Animate(
          target: canAnim ? 0 : 1,
          effects: [
            SlideEffect(
                begin: Offset(2, 0),
                end: Offset(0, 0),
                duration: 600.ms,
                delay: 1000.ms)
          ],
          child: AnswerBubble(
            letter: 'D',
            answer: answersD[currentStep],
            backroundColor: colorD,
            checkAnswer: CheckAnswer,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (nastavi)
          Animate(
            effects: [SlideEffect(begin: Offset(0, 1), end: Offset(0, 0))],
            child: ElevatedButton(
                onPressed: () => AnimLeave(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700,
                    fixedSize: Size(200, 60)),
                child: Text(
                  'Dalje',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )),
          )
      ],
    );
  }
}

class AnswerBubble extends StatefulWidget {
  const AnswerBubble(
      {super.key,
      required this.letter,
      required this.answer,
      this.backroundColor,
      required this.checkAnswer});

  final String letter;
  final String answer;
  final Color? backroundColor;
  final Function? checkAnswer;

  @override
  State<AnswerBubble> createState() => _AnswerBubbleState();
}

class _AnswerBubbleState extends State<AnswerBubble> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.checkAnswer?.call(widget.letter),
      child: Container(
        height: 75,
        margin: const EdgeInsets.fromLTRB(20, 7, 20, 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.indigo.shade700,
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: widget.backroundColor,
              ),
              child: Center(
                child: Text(
                  widget.letter,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: AutoSizeText(
                widget.answer,
                overflow: TextOverflow.visible,
                softWrap: true,
                minFontSize: 11,
                maxLines: 4,
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
