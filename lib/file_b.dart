import 'package:flutter/material.dart';
import 'file_a.dart';
import 'package:provider/provider.dart';

class ClassB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyClass myClass = Provider.of<MyClass>(context);
    String variableAValue = myClass.classA.variableA;

    return Scaffold(
      body: Center(
        child: Text(variableAValue),
      ),
    );
  }
}
