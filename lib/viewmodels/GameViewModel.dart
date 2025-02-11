import 'package:flutter/material.dart';
import '../models/MapModel.dart';

class GameViewModel extends ChangeNotifier {
  late MapModel _mapModel;

  GameViewModel(int nbLine, int nbCol, int nbBomb) {
    _mapModel = MapModel(nbLine: nbLine, nbCol: nbCol, nbBomb: nbBomb);
    generateMap();
  }

  // Getters pour accéder aux attributs du modèle
  int get nbLine => _mapModel.nbLine;
  int get nbCol => _mapModel.nbCol;
  int get nbBomb => _mapModel.nbBomb;
  List<List<CaseModel>> get cases => _mapModel.cases;

  // Génération de la grille du jeu
  void generateMap() {
    _mapModel.generateMap();
    notifyListeners();
  }

  // Gestion du clic sur une case
  void click(int x, int y) {
    if (_mapModel.hasFlag(x, y)) return; // Ne pas révéler si drapeau

    _mapModel.reveal(x, y);

    if (_mapModel.isBomb(x, y)) {
      _mapModel.explode(x, y);
    }

    notifyListeners();
  }

  // Gestion du clic long (pose de drapeau)
  void onLongPress(int x, int y) {
    _mapModel.toggleFlag(x, y);
    notifyListeners();
  }

  // Récupérer l'icône correspondant à l'état de la case
  Widget getIcon(int x, int y) {
    final caseModel = _mapModel.getCase(x, y);

    if (caseModel == null) return SizedBox.shrink();

    if (caseModel.hidden) {
      return caseModel.hasFlag
          ? Image.asset('assets/images/flag.png', height: 40)
          : Container(width: 40, height: 40, color: Colors.grey);
    } else if (caseModel.hasBomb) {
      return caseModel.hasExploded
          ? Image.asset('assets/images/exploded_bomb.png', height: 40)
          : Image.asset('assets/images/bomb.png', height: 40);
    } else {
      switch (caseModel.number) {
        case 1:
          return Image.asset('assets/images/1.png', height: 40);
        case 2:
          return Image.asset('assets/images/2.png', height: 40);
        case 3:
          return Image.asset('assets/images/3.png', height: 40);
        case 4:
          return Image.asset('assets/images/4.png', height: 40);
        case 5:
          return Image.asset('assets/images/5.png', height: 40);
        case 6:
          return Image.asset('assets/images/6.png', height: 40);
        case 7:
          return Image.asset('assets/images/7.png', height: 40);
        case 8:
          return Image.asset('assets/images/8.png', height: 40);
        default:
          return Image.asset('assets/images/0.png', height: 40);
      }
    }
  }
}
