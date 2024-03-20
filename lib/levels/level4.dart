import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:SecLab/levels/lvlDone.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Level4 extends StatefulWidget {
  const Level4({super.key});

  @override
  State<Level4> createState() => _Level4State();
}

class _Level4State extends State<Level4> {
  int currentStep = 0;
  int totalSteps = 5;

  bool nastavi = false;
  bool canAnim = false;
  bool canAnswer = true;

  Color? colorA;
  Color? colorB;

  String message = 'Prepoznati na slici da li je u pitanju phishing ili ne.';

  final List<String> questionHelp = [
    'Česta prevara u kojoj se moli korisnik da uplati neku taksu ili proviziju kako bi mu se isporučila roba, iako korisnik nije ništa naručio. Na ovakve poruke je bolje ne odgovarati i ne kliknuti na linkove.',
    'Glavni pokazatelji na phishing su loša gramatika i pravopis. Takođe treba obratiti pažnju na e-mail pošiljaoca, ako su nepoznati, sumnjivi ili nemaju veze sa sadržajem e-maila.',
    'Paypal je jedna od najčešćih platformi za prevaru jer je direktno povezana sa bankovnim računom korisnika. E-mail često uključuje PayPal logo i pokušava da izazove paniku sa porukom “Postoji problem sa vašim nalogom, kliknite ovde da ga popravite”',
    'Ova prevara postoji već duže vreme i postoji dobar razlog za to – funkcioniše. U e-mailu ponudiće Vam veliku sumu novca u zamenu za vaše bankovne podatke. Ne samo da nećete dobiti obećani novac, već će ga skinuti sa Vašeg računa.',
    'U ovom primeru izgleda kao da je ovo upozorenje stiglo od administratora Vašeg domena koji zahteva da kliknete na link. Ali samo kada postavite pokazivač miša iznad linka otkriva se da vodi na sasvim nepoznatu web stranicu sa komplikovanom adresom.',
  ];

  final List<String> imageSources = [
    'assets/images/phishing/Slika2.jpeg',
    'assets/images/phishing/Slika1.jpg',
    'assets/images/phishing/Slika3.png',
    'assets/images/phishing/Slika4.png',
    'assets/images/phishing/Slika5.png',
  ];

  final List<String> corrects = ['A', 'A', 'A', 'A', 'A'];

  int correctAnswers = 0;

  @override
  void initState() {
    message = 'Prepoznati na slici da li je u pitanju phishing ili ne.';
    colorA = Colors.indigo;
    colorB = Colors.indigo;
  }

  void AnimLeave() async {
    setState(() {
      canAnim = true;
      Future.delayed(Duration(milliseconds: 1500), () {
        NextStep();
      });
    });
  }

  void NextStep() {
    if (currentStep < totalSteps - 1) {
      setState(() {
        currentStep++;

        colorA = Colors.indigo;
        colorB = Colors.indigo;

        nastavi = false;
        canAnim = false;
        canAnswer = true;
        message = 'Prepoznati na slici da li je u pitanju phishing ili ne.';
      });
    } else {
      int finalPoints = correctAnswers * 15;
      ///LEVEL DONE
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LvlDone(
                  levelPoints: finalPoints,
                  totalQuestions: totalSteps,
                  correctQuestions: correctAnswers,
                  lvlId: 4,
                  minigamesDone: 0,
                  statsLocation: 'phishing')));
    }
  }

  void CheckAnswer(String btn) {
    if (canAnswer == true) {
      setState(() {
        canAnswer = false;
        message = questionHelp[currentStep];

        if (corrects[currentStep] == 'A') {
          colorA = Colors.green;
          colorB = Colors.red;
        } else {
          colorA = Colors.red;
          colorB = Colors.green;
        }

        if (btn == corrects[currentStep]) {
          correctAnswers++;
        }
        nastavi = true;
      });
    }
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
                    'Phishing: Vrsta sajber napada gde napadači lažno predstavljaju legitimne entitete kako bi prevarili pojedince da otkriju osetljive informacije, kao što su lozinke ili podaci o kreditnoj kartici.',
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
                  'Nivo 4 - Phishing',
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
            Container(
                height: 420,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.indigo.shade700,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.yellow[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      imageSources[currentStep],
                      height: 230,
                    )
                  ],
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnswerBtn(
                    backroundColor: colorA,
                    btnText: 'SPAM/IZBRIŠI',
                    btnIcon: Icons.block,
                    letter: 'A',
                    checkAnswer: CheckAnswer,
                  ),
                  AnswerBtn(
                    backroundColor: colorB,
                    btnText: 'PRIHVATI/KLIKNI',
                    btnIcon: Icons.check,
                    letter: 'B',
                    checkAnswer: CheckAnswer,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
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

class AnswerBtn extends StatefulWidget {
  const AnswerBtn(
      {super.key,
      this.backroundColor,
      this.btnIcon,
      required this.btnText,
      this.checkAnswer,
      required this.letter});

  final Color? backroundColor;
  final IconData? btnIcon;
  final String btnText;
  final String letter;
  final Function? checkAnswer;

  @override
  State<AnswerBtn> createState() => _AnswerBtnState();
}

class _AnswerBtnState extends State<AnswerBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.checkAnswer?.call(widget.letter),
      child: Container(
        width: 170,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.backroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.btnIcon,
              color: Colors.yellow[700],
              size: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.btnText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
