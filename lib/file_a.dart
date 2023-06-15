import 'package:flutter/foundation.dart';

class ClassA {
  String variableA = 'Value from Class A';
}

class MyClass with ChangeNotifier {
  ClassA classA = ClassA();

  void updateVariableA(String newValue) {
    classA.variableA = newValue;
    notifyListeners();
  }
}
