import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String rock = '✊';
  static const String scissors = '✌';
  static const String paper = '✋';
  static const String win = '勝ち　　';
  static const String draw = '引き分け';
  static const String lose = '負け　　';
  static const double textSmall = 20;
  static const double textMedium = 35;
  static const double textLarge = 44;

  String myTurn = '';
  String opponentTurn = '';
  String result = '';
  int game = 0;
  List<Widget> historyList = [];
  int countWin = 0;
  int countDraw = 0;
  int countLose = 0;

  void selectHand(String selectedHand) {
    myTurn = selectedHand;
    generateOpponentHand();
    judge();
    makeHistory();
    setState(() {});
  }

  void generateOpponentHand() {
    switch (Random().nextInt(3)) {
      case 0:
        opponentTurn = rock;
        break;
      case 1:
        opponentTurn = scissors;
        break;
      case 2:
        opponentTurn = paper;
        break;
      default:
        opponentTurn = '';
        break;
    }
  }

  void judge() {
    if (myTurn == opponentTurn) {
      result = draw;
      countDraw++;
    } else if (myTurn == rock && opponentTurn == scissors ||
        myTurn == scissors && opponentTurn == paper ||
        myTurn == paper && opponentTurn == rock) {
      result = win;
      countWin++;
    } else {
      result = lose;
      countLose++;
    }
  }

  void makeHistory() {
    game++;
    String resultSymbol;
    switch (result) {
      case win:
        resultSymbol = '○';
        break;
      case draw:
        resultSymbol = '△';
        break;
      case lose:
        resultSymbol = '●';
        break;
      default:
        resultSymbol = '';
        break;
    }

    if (historyList.isNotEmpty) {
      historyList.removeAt(historyList.length - 1); //見切れ対策の最終空行を一度削除
    }
    historyList.add(
      ListTile(
          title: Text(
              '${game.toString().padLeft(2, '  ')}試合目　$resultSymbol　$myTurn vs $opponentTurn')),
    );
    historyList.add(
      const ListTile(title: Text('')), //見切れ対策で最終行に空行を入れる
    );
  }

  clearResult() {
    myTurn = '  ';
    opponentTurn = '  ';
    result = '  ';
    countWin = 0;
    countDraw = 0;
    countLose = 0;
    game = 0;
    historyList.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('じゃんけん'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: DefaultTextStyle.merge(
          style: const TextStyle(fontSize: textMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '下の３つから選んでください',
                style: TextStyle(fontSize: textSmall),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectHand(rock);
                    },
                    child: const Text(
                      rock,
                      style: TextStyle(fontSize: textLarge),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectHand(scissors);
                    },
                    child: const Text(
                      scissors,
                      style: TextStyle(fontSize: textLarge),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectHand(paper);
                    },
                    child: const Text(
                      paper,
                      style: TextStyle(fontSize: textLarge),
                    ),
                  ),
                ],
              ),
              Text(
                'あなた : $myTurn',
              ),
              Text(
                'あいて : $opponentTurn',
              ),
              Text(
                '結果 : $result',
              ),
              Text(
                '$countWin勝 $countDraw分 $countLose負',
              ),
              ElevatedButton(
                onPressed: () {
                  clearResult();
                },
                child: const Text(
                  '結果をクリア',
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemExtent: 30,
                  itemCount: historyList.length,
                  itemBuilder: (context, i) => historyList[i],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
