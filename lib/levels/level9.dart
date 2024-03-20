import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Level9 extends StatefulWidget {
  const Level9({super.key});

  @override
  State<Level9> createState() => _Level9State();
}

class _Level9State extends State<Level9> {
  int currentStep = 0;
  int totalSteps = 5;

  final List<String> questions = [
    'Na računaru je izašlo obaveštenje da je detektovan sajber napad, koji je Vaš prvi korak?',
    'Nakon što je osoblje informisano o napadu, koji je sledeći korak?',
    'Kada su otkriveni zaraženi računari, šta je potrebno uraditi?',
    'Pored zaraženih računara otkriveno je da su pogodjeni i mrežni servisi, šta je potrebno uraditi?',
    'Svi potrebni koraci su odradjeni, koji od odgovora predstavlja dobro rešenje za saniranje štete sajber napada?'
  ];

  final List<String> answersA = [
    'Propajte samostalno da rešite problem',
    'Restartovati ceo sistem',
    'Izolovati zaražene računare kako bi sprečili dalje širenje infekcije u organizaciji',
    'Onemogućiti ili blokirati pristup tim servisima dok se ne pojavi zakrpa',
    'Zabraniti zaposlenima na neko vreme korišćenje interneta'
  ];
  final List<String> answersB = [
    'Zanemarite, možda je lažna uzbuna',
    'Pomoću web gateway, firewall i bezbednosnih rešenja za endpoint identifikovati zaražene sisteme',
    'Instaliranje antivirusnog softvera',
    'Zaražene servise je dozvoljeno korisiti sa već zaraženih računara',
    'Što pre krenuti ponovo sa radom'
  ];
  final List<String> answersC = [
    'Ugasite računar i upalite kasnije',
    'Ručno proći kroz svaki računar i pronaći koji su zaraženi',
    'Poslati podatke sa njih na druge "zdrave" računare',
    'Zanemariti ih i nastaviti sa redovnim poslovima',
    'Koristite pouzdana rešenja za backup i restore podataka kako bi mogli da vratite izgubljene ili kompromitovane podatke u slučaju uspešnog napada ili velikog gubitka podataka'
  ];
  final List<String> answersD = [
    'Kontaktirati osoblje ili firmu zaduženu za bezbednost sistema',
    'Nastaviti sa radom i ostalim dužnostima',
    'Obavestiti zaposlene o zaraženim računarima i nastaviti sa radom',
    'Instaliranje antivirusnog softvera',
    'Čuvati informacije o napadu od javnosti i nadležnih državnih organa'
  ];
  final List<String> corrects = ['D', 'B', 'A', 'A', 'C'];

  Color? colorA;
  Color? colorB;
  Color? colorC;
  Color? colorD;

  bool nastavi = false;
  bool canAnim = false;
  bool canAnswer = true;

  int correctAnswers = 0;
  int negativeAnswers = 0;

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
        if (btn == corrects[currentStep]) {
          correctAnswers++;
          canAnswer = false;
          nastavi = true;

          switch (btn) {
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
        } else {
          negativeAnswers++;
          switch (btn) {
            case 'A':
              colorA = Colors.red.shade700;
              break;
            case 'B':
              colorB = Colors.red.shade700;
              break;
            case 'C':
              colorC = Colors.red.shade700;
              break;
            case 'D':
              colorD = Colors.red.shade700;
              break;
          }
        }

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
      int finalPoints = correctAnswers * 15 - negativeAnswers * 5;
      if(finalPoints < 0) {
        finalPoints = 0;
      }
      ///LEVEL DONE

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LvlDone(levelPoints: finalPoints, totalQuestions: totalSteps, correctQuestions: correctAnswers, lvlId: 9, minigamesDone: 0, statsLocation: 'cyberAttack',)));
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
              'Nivo 9 - Sajber Napad',
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
