import 'dart:math';

class CaseModel {
  bool hidden;
  bool hasBomb;
  bool hasExploded;
  bool hasFlag;
  int number;

  CaseModel({
    this.hidden = true,
    this.hasBomb = false,
    this.hasExploded = false,
    this.hasFlag = false,
    this.number = 0,
  });
}

class MapModel {
  int nbLine;
  int nbCol;
  int nbBomb;
  List<List<CaseModel>> cases;

  MapModel({
    required this.nbLine,
    required this.nbCol,
    required this.nbBomb,
  }) : cases = List.generate(
    nbLine,
        (_) => List.generate(nbCol, (_) => CaseModel()),
  );

  void initCases() {
    cases = List.generate(
      nbLine,
          (_) => List.generate(nbCol, (_) => CaseModel()),
    );
  }

  void initBomb() {
    Random random = Random();
    int bombsPlaced = 0;
    while (bombsPlaced < nbBomb) {
      int x = random.nextInt(nbLine);
      int y = random.nextInt(nbCol);
      if (!cases[x][y].hasBomb) {
        cases[x][y].hasBomb = true;
        bombsPlaced++;
      }
    }
  }

  CaseModel? tryGetCase(int x, int y) {
    if (x >= 0 && x < nbLine && y >= 0 && y < nbCol) {
      return cases[x][y];
    }
    return null;
  }

  int computeNumber(int x, int y) {
    int count = 0;
    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        CaseModel? neighbor = tryGetCase(x + dx, y + dy);
        if (neighbor != null && neighbor.hasBomb) {
          count++;
        }
      }
    }
    return count;
  }

  void initNumbers() {
    for (int x = 0; x < nbLine; x++) {
      for (int y = 0; y < nbCol; y++) {
        if (!cases[x][y].hasBomb) {
          cases[x][y].number = computeNumber(x, y);
        }
      }
    }
  }

  void generateMap() {
    initCases();
    initBomb();
    initNumbers();
  }

  void reveal(int x, int y) {
    CaseModel? cell = tryGetCase(x, y);
    if (cell != null && cell.hidden && !cell.hasFlag) {
      cell.hidden = false;
      if (cell.hasBomb) {
        cell.hasExploded = true;
      }
    }
  }

  void revealAll() {
    for (var row in cases) {
      for (var cell in row) {
        cell.hidden = false;
      }
    }
  }

  void explode(int x, int y) {
    CaseModel? cell = tryGetCase(x, y);
    if (cell != null) {
      cell.hasExploded = true;
      revealAll();
    }
  }

  void toggleFlag(int x, int y) {
    CaseModel? cell = tryGetCase(x, y);
    if (cell != null && cell.hidden) {
      cell.hasFlag = !cell.hasFlag;
    }
  }

  CaseModel? getCase(int x, int y) => tryGetCase(x, y);

  bool isHidden(int x, int y) => tryGetCase(x, y)?.hidden ?? false;
  bool isBomb(int x, int y) => tryGetCase(x, y)?.hasBomb ?? false;
  bool isExploded(int x, int y) => tryGetCase(x, y)?.hasExploded ?? false;
  bool hasFlag(int x, int y) => tryGetCase(x, y)?.hasFlag ?? false;
  int getNumber(int x, int y) => tryGetCase(x, y)?.number ?? 0;

}
