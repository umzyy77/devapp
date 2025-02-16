import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/GameViewModel.dart';
import '../widgets/MapButton.dart';
import '../widgets/CustomButton.dart';
import 'HomeView.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    const double cellSize = 40.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Démineur'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: 'Back',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  },
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      "Difficulté: ${gameViewModel.nbLine}x${gameViewModel.nbCol}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Bombes restantes: ${gameViewModel.bombsRemaining}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                CustomButton(
                  text: 'Restart',
                  onPressed: () {
                    gameViewModel.generateMap();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: gameViewModel.nbCol * cellSize,
              height: gameViewModel.nbLine * cellSize,
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(cellSize),
                children: List.generate(
                  gameViewModel.nbLine,
                      (x) => TableRow(
                    children: List.generate(
                      gameViewModel.nbCol,
                          (y) => SizedBox(
                        width: cellSize,
                        height: cellSize,
                        child: MapButton(x: x, y: y),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Tooltip(
            message: "Mode Drapeau",
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(color: Colors.white),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => gameViewModel.toggleFlagMode(),
                icon: Icon(
                  Icons.flag,
                  color: gameViewModel.isFlagMode ? Colors.yellow : Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
