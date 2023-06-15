import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'chart_data.dart';

class depenses extends StatelessWidget {
  depenses({Key? key}) : super(key: key);
  final List<BarChartModel> data = [
    BarChartModel(
      year: "Loyer",
      financial: 800,
      color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
    ),
    BarChartModel(
      year: "Abonnement",
      financial: 60,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      year: "Courses",
      financial: 250,
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    BarChartModel(
      year: "Sport",
      financial: 80,
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    BarChartModel(
      year: "Transport",
      financial: 150,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    BarChartModel(
      year: "Voyage",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(Colors.pink),
    ),

  ];

  @override
  Widget build(BuildContext context) {
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
  }
}