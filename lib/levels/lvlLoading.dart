import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LevelLoading extends StatefulWidget {
  LevelLoading({super.key, required this.levelWidget});

  final Widget levelWidget;

  @override
  State<LevelLoading> createState() => _LevelLoadingState();
}

class _LevelLoadingState extends State<LevelLoading> {
  String message = '';

  final List<String> tips = [
    'Ljudska greška čini 95% svih prekršaja sajber bezbednosti.',
    'Postoji više od milijardu zlonamernih programa.',
    'Dark veb je centar za ilegalne sajber aktivnosti.',
    'Veštačka inteligencija se koristi za poboljšanje odbrane sajber bezbednosti',
    'Incidenti u vezi sa sajber-bezbednošću mogu poremetiti kritičnu infrastrukturu, kao što su električne mreže i transportni sistemi.',
    'Incidenti u vezi sa sajber-bezbednošću mogu dovesti do gubitka poverenja i lojalnosti kupaca.',
    'Redovno ažurirajte svoj softver i operativne sisteme.',
    'Zahtevajte višefaktorsku autentifikaciju za sve svoje naloge.',
    'Budite oprezni kada pritiskate na linkove ili preuzimate priloge u e-porukama ili porukama.',
    'Čuvajte svoje uređaje fizički bezbednim i izbegavajte da ih ostavljate bez nadzora na javnim mestima.',
    'Koristite jake i jedinstvene lozinke za sve svoje naloge.',
    'Nemojte koristiti istu lozinku za više naloga.',
    'Nemojte instalirati aplikacije iz nepouzdanih izvora.',
    'DDoS (Distributed Denial of Service) napad: Napad koji preplavi ciljni sistem ili mrežu poplavom saobraćaja, čineći ga nedostupnim legitimnim korisnicima.',
    'Šifrovanje (Enkripcija): Proces pretvaranja podataka u formu koju neovlašćene osobe ne mogu lako razumeti, čime se obezbeđuje njihova poverljivost.',
    'Malware: Skraćenica za zlonamerni softver, odnosi se na bilo koji softver dizajniran da ošteti ili iskorišćava računarske sisteme, uključujući viruse, crve, ransomvare i špijunski softver.',
    'Phishing: Vrsta sajber napada gde napadači lažno predstavljaju legitimne entitete kako bi prevarili pojedince da otkriju osetljive informacije, kao što su lozinke ili podaci o kreditnoj kartici.',
    'Društveni inženjering: Upotreba tehnika psihološke manipulacije da bi se pojedinci obmanuli da otkriju osetljive informacije ili da izvrše radnje koje mogu da ugroze bezbednost.',
    'Politika bezbednosti: Skup pravila, smernica i procedura koje definišu kako organizacija štiti svoja informaciona sredstva i obezbeđuje bezbednost svojih sistema i mreža.',
    'Firewall: Sigurnosni uređaj ili softver koji nadgleda i kontroliše dolazni i odlazni mrežni saobraćaj na osnovu unapred određenih bezbednosnih pravila.',
    'Patch: Ažuriranje softvera koje popravlja ranjivosti ili dodaje nove funkcije za poboljšanje bezbednosti i funkcionalnosti programa ili operativnog sistema.',
    'Cilj socijalnog inženjeringa je nalaženje slabosti u ljudskom elementu distribuiranih informacionih sistema i zloupotreba tih slabosti u cilju postizanja nekog cilja.',
  ];

  void delayLoading() async {
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.levelWidget));
      print('Done');
    });

  }

  void chooseTip(){
    final rand = new Random();
    message = tips[rand.nextInt(tips.length)];
  }

  @override
  void initState() {
    chooseTip();
    delayLoading();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo.shade900,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Zanimljivost:',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.yellow.shade700,
                  ),
                ),
              ),
              SizedBox(height: 100,),
              SpinKitRing(
                color: Colors.yellow.shade700,
                size: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
