import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

int totalSteps = 4;

class Level6 extends StatefulWidget {
  Level6({super.key, required this.currentStep, required this.levelIndex});

  int currentStep = 0;
  int levelIndex = 0;

  @override
  State<Level6> createState() => _Level6State();
}

class _Level6State extends State<Level6> {

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
                'Enkripcija (encription) predstavlja šifrovanje podataka tako da se oni ne mogu rastumačiti bez ključa (tajne šifre).',
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
    levelParts = [EncriptionIntro(), Level6Quiz()];
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
                  'Nivo 6 - Enkripcija',
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


class EncriptionIntro extends StatefulWidget {
  const EncriptionIntro({super.key});

  @override
  State<EncriptionIntro> createState() => _EncriptionIntroState();
}

class _EncriptionIntroState extends State<EncriptionIntro> {

  bool canAnim = false;

  void ContinueLvl() {
    setState(() {
      canAnim = true;
      Future.delayed(Duration(milliseconds: 1500), () {
        //LVL DONE
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Level6(currentStep: 1, levelIndex: 1)));

      });
    });
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
                Text('Primer enkripcije poruke',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.yellow[700],
                      fontSize: 22,
                    )),
                SizedBox(height: 10,),
                Image.asset(
                  'assets/images/encription/Enkripcija.png',
                  height: 200,
                ),
                SizedBox(height: 10,),
                Text('Ovde šifrujemo poruku "TAJNA PORUKA" šifrom "WNS". Na svaki znak poruke, sabira se jedan znak šifre. Tako dobijamo nečitljiv, šifrovani tekst. Da bismo dešifrovali tekst, potrebno je da od svakog znaka (bajta) šifrovanog teksta oduzimamo po jedan znak šifre.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.yellow[700],
                      fontSize: 16,
                    )),
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
          child: ElevatedButton(
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
        ),
      ],
    );
  }
}

class Level6Quiz extends StatefulWidget {
  const Level6Quiz({super.key});

  @override
  State<Level6Quiz> createState() => _Level6QuizState();
}

class _Level6QuizState extends State<Level6Quiz> {

  int currentStep = 0;
  int totalQuestions = 3;

  final List<String> questions = [
    'Poruka "Message" je enkriptovana kljucem ABC (A+A=B, A+B=C, A+C=D). Kako izgleda enkriptovana poruka?',
    'Poruka "Tajna Poruka" je enkriptovana metodom "slovo + 2" (A->C, B->D,..., X->Z, Y->A, Z->B). Kako izgleda enkriptovana poruka?',
    'Poruka "Tajna Poruka" je enkriptovana metodom (A->Z, B->Y, C->X..., X->C, Y->B, Z->A). Kako izgleda enkriptovana poruka?'
  ];

  final List<String> answersA = [
    'Ngvveh',
    'Vclbn Rsikan',
    'Fprmn Skanfw'
  ];
  final List<String> answersB = [
    'Ngvtih',
    'Vqcae Krpcas',
    'Gzyhz Klisax'
  ];
  final List<String> answersC = [
    'Naveir',
    'Vclpc Rqtwmc',
    'Dasfx Jmlkji'
  ];
  final List<String> answersD = [
    'Mcvvaq',
    'Gljac Rimikm',
    'Gzqmz Klifpz'
  ];
  final List<String> corrects = ['B', 'C', 'D'];

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
      //correctAnswers++;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LvlDone(levelPoints: finalPoints, totalQuestions: totalQuestions, correctQuestions: correctAnswers, lvlId: 6, minigamesDone: 1, statsLocation: 'encription')));

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
                  fontSize: 19,
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
