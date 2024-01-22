import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clickbattle/configs/config.dart';
import 'package:clickbattle/components/click_area.dart';
import 'package:clickbattle/components/score_display.dart';

void main() {
  runApp(MyClickBattleApp());
}

class MyClickBattleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClickBattleHomePage(),
    );
  }
}

class ClickBattleHomePage extends StatefulWidget {
  @override
  _ClickBattleHomePageState createState() => _ClickBattleHomePageState();
}

class _ClickBattleHomePageState extends State<ClickBattleHomePage> {
  int player1Score = 0;
  int player2Score = 0;
  int timerSeconds = ClickBattleConfig.timerInitTime;

  bool isGameOver = false;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timerSeconds > 0) {
          timerSeconds--;
        } else {
          isGameOver = true; // Disable clicking when the timer reaches 0
          t.cancel(); // Stop the timer
          showRestartDialog();
        }
      });
    });
  }

  void showRestartDialog() {
    String resultMessage;
    if (player1Score > player2Score) {
      resultMessage = 'Red wins!';
    } else if (player2Score > player1Score) {
      resultMessage = 'Blue wins!';
    } else {
      resultMessage = 'It\'s a tie!';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over. $resultMessage'),
          content: Text(
              'Red: $player1Score Blue: $player2Score\nDo you want to restart the game?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      timerSeconds = ClickBattleConfig.timerInitTime;
      isGameOver = false;
      player1Score = 0;
      player2Score = 0;
    });
    startTimer();
  }

  void _incrementPlayer1() {
    if (!isGameOver) {
      setState(() {
        player1Score++;
      });
    }
  }

  void _incrementPlayer2() {
    if (!isGameOver) {
      setState(() {
        player2Score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ClickArea(
                onTap: _incrementPlayer1,
                color: ClickBattleConfig.player1Color,
                angle: 3.14159,
              ),
              ClickArea(
                onTap: _incrementPlayer2,
                color: ClickBattleConfig.player2Color,
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 80,
            right: 0,
            bottom: MediaQuery.of(context).size.height / 2 - 80,
            child: Center(
              child: RotatedBox(
                quarterTurns: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ClickBattleConfig.appName,
                        style: TextStyle(
                          fontSize: ClickBattleConfig.appNameFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$timerSeconds',
                            style: TextStyle(
                              fontSize: ClickBattleConfig.timerFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.access_time, // Clock icon
                            size: ClickBattleConfig.timerIconSize,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '$timerSeconds',
                            style: TextStyle(
                              fontSize: ClickBattleConfig.timerFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScoreDisplay(
                            score: player1Score,
                            color: ClickBattleConfig.player2Color,
                            rotationAngle: 1.5708,
                          ),
                          SizedBox(width: 20),
                          ScoreDisplay(
                            score: player2Score,
                            color: ClickBattleConfig.player1Color,
                            rotationAngle: -1.5708,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
