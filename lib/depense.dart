
class Depense {
  int _idDepense;
  String _intitule;
  int _valeur;
  bool _fixeCharge = false;

  //constructeur
  Depense(this._idDepense,this._intitule, this._valeur);

  //getters and setters
  bool get fixeCharge => _fixeCharge;

  set fixeCharge(bool value) {
    _fixeCharge = value;
  }

  int get valeur => _valeur;

  set valeur(int value) {
    _valeur = value;
  }

  String get intitule => _intitule;

  set intitule(String value) {
    _intitule = value;
  }

}