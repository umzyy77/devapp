import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/GameViewModel.dart';
import '../widgets/MapButton.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Démineur'),
        backgroundColor: Colors.blueGrey, // Améliore la visibilité
        actions: [
          IconButton(
            icon: Icon(
              gameViewModel.isFlagMode ? Icons.flag : Icons.touch_app,
              color: gameViewModel.isFlagMode ? Colors.yellow : Colors.white, // Rendre le bouton visible
              size: 30, // Agrandir l'icône
            ),
            onPressed: () => gameViewModel.toggleFlagMode(),
            tooltip: "Mode Drapeau", // Ajout d'une info-bulle
          ),
        ],
      ),
      body: Center(
        child: Table(
          children: List.generate(
            gameViewModel.nbLine,
                (x) => TableRow(
              children: List.generate(
                gameViewModel.nbCol,
                    (y) => MapButton(x: x, y: y),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
