import 'dart:math';
import 'CaseModel.dart';

class MapModel {
  int nbLine = 0;
  int nbCol = 0;
  int nbBomb = 0;
  List<List<CaseModel>> _cases = [];

  MapModel(this.nbLine, this.nbCol, this.nbBomb) {
    generateMap();
  }

  void initCases() {
    _cases = List.generate(
      nbLine,
          (_) => List.generate(nbCol, (_) => CaseModel()),
    );
  }

  void initBomb() {
    int bombsPlaced = 0;
    Random random = Random();
    while (bombsPlaced < nbBomb) {
      int x = random.nextInt(nbLine);
      int y = random.nextInt(nbCol);
      if (!_cases[x][y].hasBomb) {
        _cases[x][y].hasBomb = true;
        bombsPlaced++;
      }
    }
  }

  void initNumbers() {
    for (int i = 0; i < nbLine; i++) {
      for (int j = 0; j < nbCol; j++) {
        if (!_cases[i][j].hasBomb) {
          _cases[i][j].number = computeNumber(i, j);
        }
      }
    }
  }

  int computeNumber(int x, int y) {
    int count = 0;
    List<CaseModel?> neighbors = getNeighbors(x, y);
    for (var neighbor in neighbors) {
      if (neighbor != null && neighbor.hasBomb) {
        count++;
      }
    }
    return count;
  }

  List<CaseModel?> getNeighbors(int x, int y) {
    List<CaseModel?> neighbors = [];
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        neighbors.add(tryGetCase(x + i, y + j));
      }
    }
    return neighbors;
  }

  CaseModel? tryGetCase(int x, int y) {
    if (x >= 0 && x < nbLine && y >= 0 && y < nbCol) {
      return _cases[x][y];
    }
    return null;
  }

  void generateMap() {
    initCases();
    initBomb();
    initNumbers();
  }

  void reveal(int x, int y) {
    if (_cases[x][y].hidden) {
      _cases[x][y].hidden = false;
      if (_cases[x][y].hasBomb) {
        explode(x, y);
      }
    }
  }

  void revealAll() {
    for (var row in _cases) {
      for (var cell in row) {
        cell.hidden = false;
      }
    }
  }

  void explode(int x, int y) {
    _cases[x][y].hasExploded = true;
    revealAll();
  }

  void toggleFlag(int x, int y) {
    if (_cases[x][y].hidden) {
      _cases[x][y].hasFlag = !_cases[x][y].hasFlag;
    }
  }

  List<List<CaseModel>> get cases => _cases;
}
