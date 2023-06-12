
import 'depense.dart';

class User{
  Map<int,Depense> mesDepenses = Map<int,Depense>();


  void addDepense(int id,Depense depense){
    mesDepenses[id]= depense;
  }

  void deleteDepense(int id){
    mesDepenses.remove(id);
  }

  List<double> calculatePercentageValues(double salary, List<double> percentages) {

    List<double> percentageValues = [];
    for (double percentage in percentages) {
      double value = (percentage / 100) * salary;
      percentageValues.add(value);
    }
    return percentageValues;
  }

  void main() {
    // Exemple d'utilisation de la fonction
    double salary = 5000.0;
    List<double> percentages = [10.0, 20.0, 30.0];

    List<double> percentageValues = calculatePercentageValues(salary, percentages);

    /*print("Salaire : $salary");
    print("Pourcentages : $percentages");
    print("Valeurs en pourcentage du salaire : $percentageValues");
     */
  }


}