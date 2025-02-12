import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/GameViewModel.dart';
import '../widgets/MapButton.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    const double cellSize = 40.0; // Taille fixe des cases

    return Scaffold(
      appBar: AppBar(
        title: const Text('Démineur'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(
              gameViewModel.isFlagMode ? Icons.flag : Icons.touch_app,
              color: gameViewModel.isFlagMode ? Colors.yellow : Colors.white,
              size: 30,
            ),
            onPressed: () => gameViewModel.toggleFlagMode(),
            tooltip: "Mode Drapeau",
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: gameViewModel.nbCol * cellSize,
          height: gameViewModel.nbLine * cellSize,
          child: Table(
            defaultColumnWidth: FixedColumnWidth(cellSize),
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
    );
  }
}