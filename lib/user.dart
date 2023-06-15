
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
  Map<String,double> calculatePercentageValues(double salaire, Map<String,double> pourcentages) {

    var percentageValues = Map<String,double>();
    pourcentages.forEach((cle,valeur) =>
    pourcentages[cle] = 0);
    if(salaire<100){
        percentageValues['epargne']=salaire;
        return percentageValues;
    }
    pourcentages.forEach((cle,valeur) =>
        pourcentages[cle] = (salaire*valeur)/100);
    return percentageValues;
  }

  var exemple ={'epargne':20,'shopping':10,'restaurant':25,'voyage':35,'imprevu':10};

}