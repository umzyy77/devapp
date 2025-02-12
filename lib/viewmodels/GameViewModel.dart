import 'package:flutter/foundation.dart';
import '../models/MapModel.dart';
import '../models/CaseModel.dart';
import 'package:flutter/material.dart';

class GameViewModel extends ChangeNotifier {
  final MapModel _mapModel;

  GameViewModel(this._mapModel);

  List<List<CaseModel>> get cases => _mapModel.cases;
  int get nbLine => _mapModel.nbLine;
  int get nbCol => _mapModel.nbCol;
  int get nbBomb => _mapModel.nbBomb;

  void generateMap() {
    _mapModel.generateMap();
    notifyListeners();
  }

  void click(int x, int y) {
    if (!_mapModel.cases[x][y].hasFlag) {
      _mapModel.reveal(x, y);
      if (_mapModel.cases[x][y].hasBomb) {
        _mapModel.revealAll();
      }
      notifyListeners();
    }
  }

  void onLongPress(int x, int y) {
    _mapModel.toggleFlag(x, y);
    notifyListeners();
  }

  Widget getIcon(CaseModel caseModel) {
    if (caseModel.hasFlag) {
      return Image.asset('assets/images/flag.png', height: 40);
    } else if (!caseModel.hidden) {
      if (caseModel.hasBomb) {
        return caseModel.hasExploded
            ? Image.asset('assets/images/exploded_bomb.png', height: 40)
            : Image.asset('assets/images/bomb.png', height: 40);
      } else {
        return Image.asset('assets/images/${caseModel.number ?? 0}.png', height: 40);
      }
    }
    return Container();
  }
}
