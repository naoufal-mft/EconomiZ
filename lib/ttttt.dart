import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file_a.dart';
import 'file_b.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyClass(),
      child: MaterialApp(
        title: 'Flutter Provider Example',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyClass myClass = Provider.of<MyClass>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Variable A value: ${myClass.classA.variableA}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                myClass.updateVariableA('New Value');
              },
              child: Text('Update Variable A'),
            ),
          ],
        ),
      ),
    );
  }
}
