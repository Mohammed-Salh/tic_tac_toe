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
  var _P1Score = 0;
  var _P2Score = 0;

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
            onLongPress: resetAll,
            onPressed: restGame,
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
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
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: const Text(
                  'player1',
                  style: TextStyle(
                    backgroundColor: Colors.red,
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 155,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: const Text(
                  'player2',
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 43,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Text(
                  '$_P1Score',
                  style: const TextStyle(
                    backgroundColor: Colors.red,
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 235,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Text(
                  '$_P2Score',
                  style: const TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ],
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
      if (checkWinner()) restGame();
    });
  }

  bool checkWinner() {
    // no winners yet
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      _P2Score += 1;
      return true;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      _P2Score += 1;
      return true;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      _P2Score += 1;
      return true;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      _P2Score += 1;
      return true;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      _P2Score += 1;
      return true;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      _P2Score += 1;
      return true;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      _P2Score += 1;
      return true;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      _P1Score += 1;
      return true;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      _P2Score += 1;
      return true;
    }
    return false;
    //   if (winner == 1) {
    //     showDialog(
    //       context: context,
    //       builder: (_) => WinnerDialog(
    //         Title: 'player_1',
    //         actionText: 'press the reset button to start again',
    //         callback: restGame(),
    //       ),
    //     );
    //   } else {
    //     showDialog(
    //       context: context,
    //       builder: (_) => WinnerDialog(
    //         Title: 'player_1',
    //         actionText: 'press the reset button to start again',
    //         callback: restGame(),
    //       ),
    //     );
    //   }
    // }
  }

  resetAll() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttensList = doInit();
      _P1Score = 0;
      _P2Score = 0;
    });
  }

  // add your code here.

}
