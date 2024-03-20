import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LeaderBoardsUser {
  String name = '';
  int points = 0;
  int image = 1;

  LeaderBoardsUser(String name, int points, int image) {
    this.name = name;
    this.points = points;
    this.image = image;
  }
}

class LeaderBoards extends StatefulWidget {
  const LeaderBoards({super.key});

  @override
  State<LeaderBoards> createState() => _LeaderBoardsState();
}

class _LeaderBoardsState extends State<LeaderBoards> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<LeaderBoardsUser> users = [];

  Future<void> getLeaderboards() async {
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        final data = doc.data() as Map<String, dynamic>;
        LeaderBoardsUser u = new LeaderBoardsUser(
            data['username'], data['points'], data['image']);
        users.add(u);
      }
    });
    users.sort((a, b) => b.points.compareTo(a.points));
  }

  @override
  void initState() {
    //getLeaderboards();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getLeaderboards(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'RANG LISTA',
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        LeaderBoardBubble(
                          isFirst: false,
                          winnerPosition: 2,
                          winnerName: users[1].name,
                          points: users[1].points,
                          height: 170,
                          winnerImage:
                              'assets/images/profile_pics/AssetUser${users[1].image}.png',
                        ),
                        LeaderBoardBubble(
                          isFirst: true,
                          winnerPosition: 1,
                          winnerName: users[0].name,
                          points: users[0].points,
                          height: 210,
                          winnerImage:
                              'assets/images/profile_pics/AssetUser${users[0].image}.png',
                        ),
                        LeaderBoardBubble(
                          isFirst: false,
                          winnerPosition: 3,
                          winnerName: users[2].name,
                          points: users[2].points,
                          height: 140,
                          winnerImage:
                              'assets/images/profile_pics/AssetUser${users[2].image}.png',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    BottomRankings(
                      bottomUsers: users,
                    ),
                  ],
                )),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.indigo.shade900,
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'RANG LISTA',
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SpinKitRing(
                      color: Colors.yellow.shade700,
                      size: 80,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class LeaderBoardBubble extends StatelessWidget {
  final bool isFirst;

  ///final Color color;
  final int winnerPosition;
  final String winnerName;
  final String winnerImage;
  final int points;
  final double height;

  const LeaderBoardBubble(
      {super.key,
      required this.isFirst,
      required this.winnerPosition,
      required this.winnerName,
      required this.points,
      required this.height,
      required this.winnerImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Container(
              height: height,
              width: 120,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.indigo.shade400, Colors.indigo.shade800],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                  border: Border.all(color: Colors.red, width: 2)),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Stack(
              children: [
                if (isFirst)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Image.asset(
                      'assets/images/ui/Crown.png',
                      height: 70,
                      width: 70,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 65),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 3),
                        image: DecorationImage(
                          image: AssetImage(winnerImage),
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140, left: 30),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        winnerPosition.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 170,
          left: 10,
          child: Container(
            width: 100,
            child: Center(
              child: Column(
                children: [
                  Text(
                    winnerName,
                    style: TextStyle(
                      color: Colors.yellow[700],
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    points.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BottomRankings extends StatefulWidget {
  const BottomRankings({super.key, required this.bottomUsers});

  final List<LeaderBoardsUser> bottomUsers;

  @override
  State<BottomRankings> createState() => _BottomRankingsState();
}

class _BottomRankingsState extends State<BottomRankings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.indigo[500],
        ),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 6.2,
          children: [
            UserListing(
              userImage:
                  'assets/images/profile_pics/AssetUser${widget.bottomUsers[3].image}.png',
              username: widget.bottomUsers[3].name,
              userPoints: widget.bottomUsers[3].points,
            ),
            UserListing(
              userImage:
                  'assets/images/profile_pics/AssetUser${widget.bottomUsers[4].image}.png',
              username: widget.bottomUsers[4].name,
              userPoints: widget.bottomUsers[4].points,
            ),
            UserListing(
              userImage:
                  'assets/images/profile_pics/AssetUser${widget.bottomUsers[5].image}.png',
              username: widget.bottomUsers[5].name,
              userPoints: widget.bottomUsers[5].points,
            ),
            UserListing(
              userImage:
                  'assets/images/profile_pics/AssetUser${widget.bottomUsers[6].image}.png',
              username: widget.bottomUsers[6].name,
              userPoints: widget.bottomUsers[6].points,
            ),
            UserListing(
              userImage:
                  'assets/images/profile_pics/AssetUser${widget.bottomUsers[7].image}.png',
              username: widget.bottomUsers[7].name,
              userPoints: widget.bottomUsers[7].points,
            ),
            UserListing(
              userImage:
                  'assets/images/profile_pics/AssetUser${widget.bottomUsers[8].image}.png',
              username: widget.bottomUsers[8].name,
              userPoints: widget.bottomUsers[8].points,
            ),
            UserListing(
              userImage:
                  'assets/images/profile_pics/AssetUser${widget.bottomUsers[9].image}.png',
              username: widget.bottomUsers[9].name,
              userPoints: widget.bottomUsers[9].points,
            ),
          ],
        ),
      ),
    );
  }
}

class UserListing extends StatelessWidget {
  final String userImage;
  final String username;
  final int userPoints;

  const UserListing(
      {super.key,
      required this.userImage,
      required this.username,
      required this.userPoints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo[700], borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  userImage,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                username,
                style: TextStyle(
                  color: Colors.yellow.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Text(
                userPoints.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
