import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  int currentStep = 0;
  int totalSteps = 5;

  final List<String> questions = [
    'Koja je svrha sajber bezbednosti?',
    'Ko su mete sajber kriminala?',
    'Koje su potencijalne posledice kršenja sajber bezbednosti za pojedince, preduzeća i vlade?',
    'Koji je najčešći uzrok (više od 90%) za kršenje sajber bezbednosti?',
    'Koji od ponudjenih odgovora predstavlja dobru zaštitnu meru za sajber bezbednost?'
  ];

  final List<String> answersA = [
    'Svrha sajber bezbednosti je da hakerima olakša pristup osetljivim informacijama',
    'Korporacije',
    'Pojačana efikasnost rada',
    'Ljudska greška',
    'Jake lozinke'
  ];
  final List<String> answersB = [
    'Svrha sajber bezbednosti je da uspori performanse računarskih sistema kako bi se sprečilo njihovo hakovanje',
    'Zdravstvene ustanove',
    'Finansijski gubitak i/ili ometanje rada i dovodjenje do zastoja',
    'Greške hardvera',
    'Obuka zaposlenih'
  ];
  final List<String> answersC = [
    'Svrha sajber bezbednosti je da zaštiti računarske sisteme, mreže i podatke od digitalnih napada i neovlašćenog pristupa',
    'Vladine organizacije',
    'Poboljšana javna slika',
    'Napredna enkripcija',
    'Redovna ažuriranja softvera'
  ];
  final List<String> answersD = [
    'Svrha sajber bezbednosti je da nadgleda onlajn aktivnosti zaposlenih i ograniči njihov pristup određenim veb lokacijama',
    'Sve od ponudjenog',
    'Fizičke povrede',
    'Prirodne katastrofe',
    'Sve od ponudjenog'
  ];
  final List<String> corrects = ['C', 'D', 'B', 'A', 'D'];

  Color? colorA;
  Color? colorB;
  Color? colorC;
  Color? colorD;

  bool nastavi = false;
  bool canAnim = false;
  bool canAnswer = true;

  int correctAnswers = 0;

  @override
  void initState() {
    colorA = Colors.yellow.shade700;
    colorB = Colors.yellow.shade700;
    colorC = Colors.yellow.shade700;
    colorD = Colors.yellow.shade700;
  }

  void CheckAnswer(String btn) {
    if(canAnswer){
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
    });}
  }

  void NextStep() async{
    if (currentStep < totalSteps - 1) {
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
      int finalPoints = correctAnswers * 15;
      ///LEVEL DONE

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LvlDone(levelPoints: finalPoints, totalQuestions: totalSteps, correctQuestions: correctAnswers, lvlId: 1, minigamesDone: 0, statsLocation: '',)));
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
              'Nivo 1 - Uvod 1. deo',
              style: TextStyle(
                color: Colors.yellow[700],
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
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
              height: 0,
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
        ),
      ),
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
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
