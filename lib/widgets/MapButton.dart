import 'package:flutter/material.dart';
import '../models/CaseModel.dart';
import '../viewmodels/GameViewModel.dart';
import 'package:provider/provider.dart';

class MapButton extends StatelessWidget {
  final int x;
  final int y;

  const MapButton({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    final caseModel = gameViewModel.cases[x][y];

    return InkWell(
      onTap: () => gameViewModel.click(x, y),
      onLongPress: () => gameViewModel.onLongPress(x, y),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: gameViewModel.getIcon(caseModel),
        ),
      ),
    );
  }
}
