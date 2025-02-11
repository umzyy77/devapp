class CaseModel {
  bool hidden; // True si la case est cachée
  bool hasBomb; // True si la case contient une bombe
  bool hasExploded; // True si la bombe a explosé
  bool hasFlag; // True si la case a un drapeau
  int? number; // Le nombre de bombes autour de la case

  CaseModel({
    this.hidden = true,
    this.hasBomb = false,
    this.hasExploded = false,
    this.hasFlag = false,
    this.number,
  });
}
