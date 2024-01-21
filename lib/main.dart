import 'package:flutter/material.dart';
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

  void _incrementPlayer1() {
    setState(() {
      player1Score++;
    });
  }

  void _incrementPlayer2() {
    setState(() {
      player2Score++;
    });
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
                icon: Icons.touch_app,
                angle: 3.14159,
              ),
              ClickArea(
                onTap: _incrementPlayer2,
                color: ClickBattleConfig.player2Color,
                icon: Icons.touch_app,
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScoreDisplay(
                            score: player1Score,
                            color: Colors.redAccent,
                            rotationAngle: 1.5708,
                          ),
                          SizedBox(width: 20),
                          ScoreDisplay(
                            score: player2Score,
                            color: Colors.blueAccent,
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
