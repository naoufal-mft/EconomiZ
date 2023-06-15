import 'package:flutter/material.dart';
import 'basedd.dart';
import 'chart_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class depenses extends StatelessWidget {
  final int iduser;

  depenses({required this.iduser});

  Future<List<BarChartModel>> create_liste(int id) async {
    basedd bdd = await basedd();
    await bdd.initialDb();
    List<Map> result10 = await bdd.readData('SELECT * FROM charge WHERE iduser=$id');

    List<BarChartModel> data = [];

    result10.forEach((row) {
      String name = row['nom_charge'];
      double prix = double.tryParse(row['prix']) ?? 0.0;

      data.add(BarChartModel(
        year: name,
        financial: prix.toInt(),
        color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
      ));
    });

    return data;
  }

  @override
  Widget build(BuildContext context) {
    int id = iduser as int;

    return FutureBuilder<List<BarChartModel>>(
      future: create_liste(id),
      builder: (BuildContext context, AsyncSnapshot<List<BarChartModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<BarChartModel> data = snapshot.data ?? [];

        List<charts.Series<BarChartModel, String>> series = [
          charts.Series(
            id: "financial",
            data: data,
            domainFn: (BarChartModel series, _) => series.year,
            measureFn: (BarChartModel series, _) => series.financial,
            colorFn: (BarChartModel series, _) => series.color,
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Mes Depenses"),
            centerTitle: true,
            backgroundColor: Colors.cyan[700],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: charts.BarChart(
              series,
              animate: true,
            ),
          ),
        );
      },
    );
  }
}
