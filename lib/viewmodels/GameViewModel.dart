import 'package:flutter/foundation.dart';
import '../models/MapModel.dart';
import '../models/CaseModel.dart';
import 'package:flutter/material.dart';

class GameViewModel extends ChangeNotifier {
  final MapModel _mapModel;
  bool isFlagMode = false;

  GameViewModel(this._mapModel);

  List<List<CaseModel>> get cases => _mapModel.cases;
  int get nbLine => _mapModel.nbLine;
  int get nbCol => _mapModel.nbCol;
  int get nbBomb => _mapModel.nbBomb;

  void toggleFlagMode() {
    isFlagMode = !isFlagMode;
    notifyListeners();
  }

  void generateMap() {
    _mapModel.generateMap();
    notifyListeners();
  }

  void click(int x, int y) {
    if (isFlagMode) {
      onLongPress(x, y);
    } else {
      if (!_mapModel.cases[x][y].hasFlag) {
        _mapModel.reveal(x, y);
        if (_mapModel.cases[x][y].hasBomb) {
          _mapModel.revealAll();
        }
        notifyListeners();
      }
    }
  }

  void onLongPress(int x, int y) {
    if (_mapModel.cases[x][y].hidden) {
      _mapModel.toggleFlag(x, y);
      notifyListeners();
    }
  }

  Widget getIcon(CaseModel caseModel) {
    if (caseModel.hasFlag) {
      return Image.asset('assets/images/Minesweeper_flag.svg.png', height: 40);
    } else if (!caseModel.hidden) {
      if (caseModel.hasBomb) {
        return caseModel.hasExploded
            ? Image.asset('assets/images/exploded_bomb.png', height: 40)
            : Image.asset('assets/images/bomb.png', height: 40);
      } else {
        return Image.asset('assets/images/Minesweeper_${caseModel.number ?? 0}.svg.png', height: 40);
      }
    }
    return Container();
  }
}