import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

int totalSteps = 5;

class Level3 extends StatefulWidget {
  Level3({super.key, required this.currentStep, required this.levelIndex});

  int currentStep = 0;
  int levelIndex = 0;

  @override
  State<Level3> createState() => _Level3State();
}

class _Level3State extends State<Level3> {


  List<Widget> levelParts = [];


  @override
  void initState() {
    levelParts = [PWMinigame(), Level3Quiz()];
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
            child: Text(
              'Nivo 3 - Šifre',
              style: TextStyle(
                color: Colors.yellow[700],
                fontSize: 20,
              ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: StepProgressIndicator(
                    totalSteps: totalSteps,
                    currentStep: widget.currentStep + 1,
                    padding: 5,
                    size: 15,
                    selectedColor: Colors.amber,
                    unselectedColor: Colors.indigo.shade600,
                    customStep: (index, color, _) => color == Colors.green
                        ? Container(
                            decoration:
                                BoxDecoration(color: color, shape: BoxShape.circle),
                          )
                        : Container(
                            decoration:
                                BoxDecoration(color: color, shape: BoxShape.circle),
                          ),
                  ),
                ),
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

class PWMinigame extends StatefulWidget {
  const PWMinigame({super.key});

  @override
  State<PWMinigame> createState() => _PWMinigameState();
}

class _PWMinigameState extends State<PWMinigame> {
  final myController = TextEditingController();

  Icon ikonica1 = Icon(
    Icons.block,
    size: 25,
    color: Colors.red,
  );
  Icon ikonica2 = Icon(
    Icons.block,
    size: 25,
    color: Colors.red,
  );
  Icon ikonica3 = Icon(
    Icons.block,
    size: 25,
    color: Colors.red,
  );
  Icon ikonica4 = Icon(
    Icons.block,
    size: 25,
    color: Colors.red,
  );
  Icon ikonica5 = Icon(
    Icons.block,
    size: 25,
    color: Colors.red,
  );

  bool isCorrect1 = false;
  bool isCorrect2 = false;
  bool isCorrect3 = false;
  bool isCorrect4 = false;
  bool isCorrect5 = false;

  bool canAnim = false;

  void checkPW() {
    setState(() {
      if (myController.text.length >= 8) {
        ikonica1 = Icon(
          Icons.done,
          size: 25,
          color: Colors.green,
        );
        isCorrect1 = true;
      } else {
        ikonica1 = Icon(
          Icons.block,
          size: 25,
          color: Colors.red,
        );
        isCorrect1 = false;
      }

      if (myController.text.contains(RegExp(r'[a-z]'))) {
        ikonica2 = Icon(
          Icons.done,
          size: 25,
          color: Colors.green,
        );
        isCorrect2 = true;
      } else {
        ikonica2 = Icon(
          Icons.block,
          size: 25,
          color: Colors.red,
        );
        isCorrect2 = false;
      }

      if (myController.text.contains(RegExp(r'[A-Z]'))) {
        ikonica3 = Icon(
          Icons.done,
          size: 25,
          color: Colors.green,
        );
        isCorrect3 = true;
      } else {
        ikonica3 = Icon(
          Icons.block,
          size: 25,
          color: Colors.red,
        );
        isCorrect3 = false;
      }

      if (myController.text.contains(RegExp(r'[0-9]'))) {
        ikonica4 = Icon(
          Icons.done,
          size: 25,
          color: Colors.green,
        );
        isCorrect4 = true;
      } else {
        ikonica4 = Icon(
          Icons.block,
          size: 25,
          color: Colors.red,
        );
        isCorrect4 = false;
      }

      if (myController.text.contains(RegExp(
          r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' // <-- Notice the escaped symbols
          "'" // <-- ' is added to the expression
          ']'))) {
        ikonica5 = Icon(
          Icons.done,
          size: 25,
          color: Colors.green,
        );
        isCorrect5 = true;
      } else {
        ikonica5 = Icon(
          Icons.block,
          size: 25,
          color: Colors.red,
        );
        isCorrect5 = false;
      }
    });
  }

  void CheckAnswer() async {
    if (isCorrect1 && isCorrect2 && isCorrect3 && isCorrect4 && isCorrect5) {
      setState(() {
        canAnim = true;
        Future.delayed(Duration(milliseconds: 1500), () {
          //LVL DONE
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Level3(currentStep: 1, levelIndex: 1)));

        });
      });
    }

  }

  @override
  void initState() {
    myController.addListener(checkPW);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.indigo.shade700,
            ),
            child: Column(
              children: [
                Text('Sastavi šifru da ispuni sve uslove',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.yellow[700],
                      fontSize: 22,
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ikonica1,
                    SizedBox(
                      width: 30,
                    ),
                    Text('Dužina od bar 8 karaktera',
                        style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 17,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ikonica2,
                    SizedBox(
                      width: 30,
                    ),
                    Text('Sadrži malo slovo',
                        style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 17,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ikonica3,
                    SizedBox(
                      width: 30,
                    ),
                    Text('Sadrži veliko slovo',
                        style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 17,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ikonica4,
                    SizedBox(
                      width: 30,
                    ),
                    Text('Sadrži broj',
                        style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 17,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ikonica5,
                    SizedBox(
                      width: 30,
                    ),
                    Text('Sadrži specijalni karakter',
                        style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 17,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                fillColor: Colors.indigo.shade700,
                filled: true,
                border: OutlineInputBorder(),
                hintText: 'password',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
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
          child: ElevatedButton(
              onPressed: () => CheckAnswer(),
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
        ),
      ],
    );
  }
}


class Level3Quiz extends StatefulWidget {
  const Level3Quiz({super.key});

  @override
  State<Level3Quiz> createState() => _Level3QuizState();
}

class _Level3QuizState extends State<Level3Quiz> {

  int currentStep = 0;
  int totalQuestions = 4;

  final List<String> questions = [
    'Izaberite najjaču šifru od ponudjenih? (username: Marko)',
    'Izaberite najslabiju šifru od ponudjenih? (username: Petar)',
    'Koji od ponuđenih odgovora predstavlja efikasnu meru zaštite naloga?',
    'Koji od ponuđenih odgovora predstavlja dobru praksu za zaštitu naloga?',
  ];

  final List<String> answersA = [
    'marko123',
    'PetarPeric123',
    'Korišćenje jake i jedinstvene lozinke',
    'Deljenje lozinke sa bliskim prijateljima',
  ];
  final List<String> answersB = [
    'MarkoMarko123',
    'Pera123!',
    'Omogućiti dvofaktorsku autentifikaciju',
    'Korišćenje različite lozinke na različitim nalozima',
  ];
  final List<String> answersC = [
    'Marko123#',
    'PeraPeric147896325',
    'Korišćenje filtera za spam poruke',
    'Korišćenje iste lozinke na više naloga',
  ];
  final List<String> answersD = [
    'MarkoMarkovic',
    'petar123',
    'Sve od ponudjenog',
    'Napraviti spisak lozinki i držati na vidljivom mestu',
  ];
  final List<String> corrects = ['C', 'D', 'D', 'B'];

  Color? colorA;
  Color? colorB;
  Color? colorC;
  Color? colorD;

  bool nastavi = false;
  bool canAnim = false;
  bool canAnswer = true;

  int correctAnswers = 0;

  void CheckAnswer(String btn) {
    if(canAnswer) {
    setState(() {
      canAnswer=false;
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
    });}
  }

  void NextStep() {
    if (currentStep < totalQuestions-1) {
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
      int finalPoints = correctAnswers * 15 + 30;
      ///LEVEL DONE
      correctAnswers++;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LvlDone(levelPoints: finalPoints, totalQuestions: totalSteps, correctQuestions: correctAnswers, lvlId: 3, minigamesDone: 1, statsLocation: 'password')));

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
