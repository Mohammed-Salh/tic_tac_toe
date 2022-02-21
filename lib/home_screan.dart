import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tic_tac_toe/game_button.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/winner_dialog.dart';

class HomeScrean extends StatefulWidget {
  HomeScrean({Key? key}) : super(key: key);

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  //
  late List<GameButton> buttensList;
  late List player1;
  late List player2;
  var activePlayer = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttensList = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    activePlayer = 1;
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  restGame() async {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttensList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: restGame,
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: buttensList.length,
        itemBuilder: (context, index) => SizedBox(
          width: 100.0,
          height: 100.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(buttensList[index].bg),
              ),
              onPressed: buttensList[index].enabled
                  ? () => playGame(buttensList[index])
                  : null,
              child: Text(
                buttensList[index].text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void playGame(GameButton GB) {
    setState(() {
      if (activePlayer == 1) {
        GB.text = "X";
        GB.bg = Colors.red;
        activePlayer = 2;
        player1.add(GB.id);
      } else {
        GB.text = "0";
        GB.bg = Colors.black;
        activePlayer = 1;
        player2.add(GB.id);
      }
      GB.enabled = false;
      checkWinner();
    });
  }

  void checkWinner() {
    var winner = -1; // no winners yet
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
          context: context,
          builder: (_) => WinnerDialog(
            Title: 'player_1',
            actionText: 'press the reset button to start again',
            callback: restGame(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => WinnerDialog(
            Title: 'player_1',
            actionText: 'press the reset button to start again',
            callback: restGame(),
          ),
        );
      }
    }
  }

  // add your code here.

}
