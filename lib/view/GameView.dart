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
      appBar: AppBar(title: const Text('Démineur')),
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