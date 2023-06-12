
class user_info{
  String _situation_famille;
  String _nommbre_enfant;
  int _region;
  int _salaire;

  user_info(this._situation_famille, this._nommbre_enfant, this._region,
      this._salaire);

  int get salaire => _salaire;

  set salaire(int value) {
    _salaire = value;
  }

  int get region => _region;

  set region(int value) {
    _region = value;
  }

  String get nommbre_enfant => _nommbre_enfant;

  set nommbre_enfant(String value) {
    _nommbre_enfant = value;
  }

  String get situation_famille => _situation_famille;

  set situation_famille(String value) {
    _situation_famille = value;
  }
}