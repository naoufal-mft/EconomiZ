
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
      double value = (percentage * 100) / salary;
      percentageValues.add(value);
    }
    return percentageValues;
  }


}