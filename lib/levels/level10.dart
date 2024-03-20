import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Level10 extends StatefulWidget {
  const Level10({super.key});

  @override
  State<Level10> createState() => _Level10State();
}

class _Level10State extends State<Level10> {
  int currentStep = 0;
  int totalSteps = 7;

  final List<String> questions = [
    'Kako se veštačka inteligencija može koristiti za poboljšanje bezbednosti na radnom mestu?',
    'Koje je jedno od ograničenja upotrebe AI u donošenju odluka na radnom mestu?',
    'Kako se AI može koristiti za poboljšanje obuke i razvoja zaposlenih?',
    'Šta je primer povrede podataka?',
    'Kako se malver može uneti u računarski sistem?',
    'Šta je primer napada socijalnog inženjeringa?',
    'Šta od sledećeg je vrsta napada na sajber bezbednost?'
  ];

  final List<String> answersA = [
    'AI se može koristiti samo za fizičku bezbednost, a ne za sajber bezbednost',
    'AI može da donosi savršene odluke bez ikakvih grešaka ili pristrasnosti',
    'AI može da zameni potrebu za ljudskim trenerima i mentorima',
    'Neovlašćen pristup informacijama o klijentima',
    'Jake lozinke',
    'Infekcija malverom',
    'Mrežna konfiguracija'
  ];
  final List<String> answersB = [
    'AI može povećati nesreće i opasnosti na radnom mestu',
    'AI može u potpunosti da zameni potrebu za ljudskim donosiocima odluka',
    'AI može da pruži personalizovana iskustva učenja i preporuke zasnovane na individualnim potrebama zaposlenih',
    'Instaliranje antivirusnog softvera',
    'Mrežni zaštitni zidovi',
    'Spear phishing',
    'Povratak podataka'
  ];
  final List<String> answersC = [
    'AI može da analizira podatke i identifikuje potencijalne bezbednosne opasnosti ili rizike u realnom vremenu',
    'AI se može koristiti samo za jednostavne zadatke donošenja odluka, a ne za složene',
    'AI može ometati učenje i rast zaposlenih pružanjem netačnih informacija',
    'Šifrovanje podataka u mirovanju',
    'Redovna ažuriranja softvera',
    'Upad u mrežu',
    'Ransomware'
  ];
  final List<String> answersD = [
    'AI se može koristiti samo u velikim organizacijama, a ne u malim preduzećima',
    'AI možda nema sposobnost da razmotri etičke ili moralne implikacije u donošenju odluka',
    'AI se može koristiti samo za obuku novih zaposlenih, a ne za stalni razvoj',
    'Prirodne katastrofe',
    'Preko zlonamernih priloga e-pošte',
    'Curenje podataka',
    'Zakrpe softvera'
  ];
  final List<String> corrects = ['C', 'D', 'B', 'A', 'D', 'B', 'C'];

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
              builder: (context) => LvlDone(levelPoints: finalPoints, totalQuestions: totalSteps, correctQuestions: correctAnswers, lvlId: 10, minigamesDone: 0, statsLocation: '',)));
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
                      fontSize: 20,
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
