import 'package:flutter/material.dart';
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
  List player_1 = [];
  List player_2 = [];
  var activePlayer = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttensList = doInit();
  }

  List<GameButton> doInit() {
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
        player_1.add(GB.id);
      } else {
        GB.text = "0";
        GB.bg = Colors.black;
        activePlayer = 1;
        player_2.add(GB.id);
      }
      GB.enabled = false;
      checkWinner();
    });
  }

  void checkWinner() {
    var Winner = -1; // no winners yet
    if (player_1.contains(1) && player_1.contains(2) && player_1.contains(3)) {
      Winner = 1;
    }
    if (player_2.contains(1) && player_2.contains(2) && player_2.contains(3)) {
      Winner = 2;
    }

    if (Winner != -1) {
      if (Winner == 1) {
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

  restGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttensList = doInit();
    });
  }
}
