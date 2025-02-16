import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/MapModel.dart';
import '../viewmodels/GameViewModel.dart';
import 'GameView.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _startGame(BuildContext context, int nbLine, int nbCol, int nbBomb) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => GameViewModel(MapModel(nbLine, nbCol, nbBomb)),
          child: const GameView(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démineur - Sélection de difficulté'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choisissez une difficulté',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _startGame(context, 10, 8, 10),
              child: const Text('Facile (10x8, 10 bombes)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _startGame(context, 18, 14, 40),
              child: const Text('Moyen (18x14, 40 bombes)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _startGame(context, 24, 20, 99),
              child: const Text('Difficile (24x20, 99 bombes)'),
            ),
          ],
        ),
      ),
    );
  }
}
