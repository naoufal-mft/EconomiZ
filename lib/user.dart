
import 'depense.dart';

class User{
  Map<int,Depense> mesDepenses = Map<int,Depense>();


  void addDepense(int id,Depense depense){
    mesDepenses[id]= depense;
  }

  void deleteDepense(int id){
    mesDepenses.remove(id);
  }

  //fonction de calcul de proposition de depenses
  /**
   * salaire double : salaire du user
   * pourcentage Map : dictionnaire contenant la paire (depenses,pourcentage de la depense par raport au budget
   *
   * retourne une Map de proposition de depenses dont la clé correspond au nom de la depense
   */
  Map<String,double> calculatePercentageValues(double salaire, Map<String,double> pourcentages) {

    var percentageValues = Map<String,double>();
    pourcentages.forEach((cle,valeur) =>
        pourcentages[cle] = (salaire*valeur)/100);
    return percentageValues;
  }


}