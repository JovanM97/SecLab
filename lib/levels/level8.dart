import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Level8 extends StatefulWidget {
  const Level8({super.key});

  @override
  State<Level8> createState() => _Level8State();
}

class _Level8State extends State<Level8> {
  int currentStep = 0;
  int totalSteps = 5;

  final List<String> questions = [
    '2010. godine, detektovan je sajber napad na tajno nuklearno postrojenje u Iranu gde je "crv" oštetio rad centrifuga za obogaćivanje uranijuma i time unazadio nuklearni program Irana (Stuxnet). Kako je "crv" ubačen u sistem?',
    '2015. godine, došlo je do ispada 3 elektrodistribucije u Ukrajini, koji su doveli do izostanka napajanja kod ~225,000 korisnika. U pitanju je bio BlackEnergy (BE) malware i sumnja se na rusku grupu hakera. Kako je ubačen malwer?',
    '2019. godine, Facebook je bio hakovan i ukradeni su podaci korisnika kao npr. njihovi telefonski brojevi? Koji broj korisničkih podataka je ukradeno?',
    'Koje od ponuđenih odgovora je klasa IT kriminalaca?',
    'Šta su "white hat" hakeri?'
  ];

  final List<String> answersA = [
    'Poslat je preko e-mail-a',
    'Grubo probijanje lozinke i upad u sistem',
    '500.000',
    'Amateri',
    '"Dobri momci“ koji rade za kompanije i traže slabosti u informacionim sistemima'
  ];
  final List<String> answersB = [
    'Neko od radnika je ušao na lažnu veb stranicu i skinuo "crva" ni ne sumnjajući da je "crv"',
    'Hakeri su fizički upali u postrojenje i ubacili BE',
    '100 miliona',
    'Zlonamerni insajderi',
    'Bivši zaposleni ili namerno ubačeni elementi koji zloupotrebljavaju odobren fizički i elektronski pristup za izvršenje napada'
  ];
  final List<String> answersC = [
    'Neko od zaposlenih je uneo "crva" ni ne sumnjajući da je "crv" na disku',
    'Ukradena je lozinka administratora',
    '419 miliona',
    'Kriminalističke organizacije',
    'Hakeri koji žele da pošalju političku poruku'
  ];
  final List<String> answersD = [
    'Hakeri su fizički upali u postrojenje i ubacili "crva"',
    'BE je dospeo u mreže napadnutih kompanija preko trojanca koji je ubačen preko spear-phishing napada',
    '2 milijarde',
    'Sve od ponudjenog',
    'Grupa hakera koji nose bele kačkete'
  ];
  final List<String> corrects = ['C', 'D', 'C', 'D', 'A'];

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
              builder: (context) => LvlDone(levelPoints: finalPoints, totalQuestions: totalSteps, correctQuestions: correctAnswers, lvlId: 8, minigamesDone: 0, statsLocation: 'www',)));
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
              'Nivo 8 - Primeri sajber napada u svetu',
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
                size: 20,
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
                      fontSize: 15,
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
