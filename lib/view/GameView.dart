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
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Grille du jeu
            SizedBox(
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
            // Bouton pour activer/désactiver le mode drapeau (à droite de la grille)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Tooltip(
                message: "Mode Drapeau",
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(color: Colors.white),
                child: Container(
                  decoration: BoxDecoration(
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
            ),
          ],
        ),
      ),
    );
  }
}