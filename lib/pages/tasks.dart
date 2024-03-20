import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tasks extends StatefulWidget {
  const Tasks({
    super.key,
  });

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int task1ID = 1;
  int task2ID = 2;
  int task3ID = 3;
  String task1Name = 'Zavrsi 1 nivo';
  String task2Name = 'Zavrsi 2 mini-igre';
  String task3Name = 'Tačno odgovori 10 pitanja';
  int task1Counter = 0;
  int task2Counter = 0;
  int task3Counter = 0;
  int task1Goal = 1;
  int task2Goal = 2;
  int task3Goal = 10;
  String task1Status = '0/1';
  String task2Status = '0/2';
  String task3Status = '0/10';
  int task1Reward = 50;
  int task2Reward = 100;
  int task3Reward = 150;

  DateTime task1Date = DateTime(2000, 1, 1);
  DateTime task2Date = DateTime(2000, 1, 1);
  DateTime task3Date = DateTime(2000, 1, 1);

  bool task1Open = true;
  bool task2Open = true;
  bool task3Open = true;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email').toString();

    final doc = await db.collection("users").doc(email);
    await doc.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> task1 = data["task1"] as Map<String, dynamic>;
        Map<String, dynamic> task2 = data["task2"] as Map<String, dynamic>;
        Map<String, dynamic> task3 = data["task3"] as Map<String, dynamic>;

        task1Date = (task1['dateDone'] as Timestamp).toDate();
        task2Date = (task2['dateDone'] as Timestamp).toDate();
        task3Date = (task3['dateDone'] as Timestamp).toDate();

        task1Open = task1['isOpen'];
        task2Open = task2['isOpen'];
        task3Open = task3['isOpen'];

        task2Counter = task2['counter'];
        task3Counter = task3['counter'];

        checkTaskInfo(email);
      }
    );
  }

  void checkTaskInfo(String email)  {
    if ((task1Date.add(Duration(hours: 23))).isBefore(DateTime.now()) && task1Open==false) {
      task1Open = true;
      task1Counter = 0;
      task1Status = '$task1Counter/$task1Goal';
      db.collection("users").doc(email).update({'task1.isOpen': true});
    } else if(task1Open==false){
      task1Counter = 1;
      task1Status = 'ODRAĐENO';
    } else {
      task1Counter = 0;
      task1Status = '$task1Counter/$task1Goal';
    }

    if ((task2Date.add(Duration(hours: 23))).isBefore(DateTime.now()) && task2Open==false) {
      task2Open = true;
      task2Counter = 0;
      task2Status = '$task2Counter/$task2Goal';
      db.collection("users").doc(email).update({'task2.isOpen': true});
    } else {
      if (task2Open) {
        task2Status = '$task2Counter/$task2Goal';
      } else {
        task2Status = 'ODRAĐENO';
      }
    }

    if ((task3Date.add(Duration(hours: 23))).isBefore(DateTime.now()) && task3Open==false) {
      task3Open = true;
      task3Counter = 0;
      task3Status = '$task3Counter/$task3Goal';
      db.collection("users").doc(email).update({'task3.isOpen': true});
    } else {
      if (task3Open) {
        task3Status = '$task3Counter/$task3Goal';
      } else {
        task3Status = 'ODRAĐENO';
      }
    }
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getTaskData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'LISTA TASKOVA',
                        style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TaskBubble(
                        taskId: task1ID,
                        taskName: task1Name,
                        taskStatus: task1Status,
                        taskReward: task1Reward.toString(),
                      ),
                      TaskBubble(
                        taskId: task2ID,
                        taskName: task2Name,
                        taskStatus: task2Status,
                        taskReward: task2Reward.toString(),
                      ),
                      TaskBubble(
                        taskId: task3ID,
                        taskName: task3Name,
                        taskStatus: task3Status,
                        taskReward: task3Reward.toString(),
                      ),
                    ],
                  ),
                ),
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
                      'LISTA TASKOVA',
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

class TaskBubble extends StatefulWidget {
  final int taskId;
  final String taskName;
  final String taskStatus;
  final String taskReward;

  const TaskBubble(
      {super.key,
      required this.taskId,
      required this.taskName,
      required this.taskStatus,
      required this.taskReward});

  @override
  State<TaskBubble> createState() => _TaskBubbleState();
}

class _TaskBubbleState extends State<TaskBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo.shade500, Colors.indigo.shade800]),
          borderRadius: const BorderRadius.all(const Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.taskName,
            style: TextStyle(
              color: Colors.yellow[600],
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.taskStatus,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'NAGRADA: ',
                style: TextStyle(
                  color: Colors.yellow[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.monetization_on_sharp,
                color: Colors.yellow[700],
              ),
              Text(
                widget.taskReward,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
