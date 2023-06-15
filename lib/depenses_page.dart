import 'dart:io';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'chart_data.dart';
import 'basedd.dart';
import 'dart:core';

class depenses extends StatelessWidget {
  depenses({Key? key}) : super(key: key);

  Future<basedd> init_bdd() async {
    basedd bdd = await basedd();
    await bdd.initialDb();
    return bdd ;
  }
  String get_date() {
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;
    String date="$month/$year";
    return date;
  }
  String get_date_prec() {
    DateTime now = DateTime.now();
    int month = now.month-1;
    int year = now.year;
    String date="$month/$year";
    return date;
  }
  Future<int> get_charge(basedd bd,String nom_charge) async {

    String date=get_date_prec();
    List<Map> result1=await bd.readData("SELECT prix FROM charge WHERE iduser=2 and nom_charge='$nom_charge' ");
    String prix_loyer = result1[0]['prix'];

    return int.parse(prix_loyer);
  }
  List a=[];
  int i = 0;
  Future<void> get_prix() async {
    basedd bd = await init_bdd();
    int Loyer = await get_charge(bd,"loyer");

    a.add(Loyer);
    int Abonnement = await get_charge(bd,"Abonnement");
    a.add(Abonnement);
    int Courses =await get_charge(bd,"Courses") ;
    a.add(Courses);
    int Sport = await get_charge(bd,"Sport");
    a.add(Sport);
    int Transport = await get_charge(bd,"Transport");
    a.add(Transport);
    int Voyage = await get_charge(bd,"Voyage");
    a.add(Voyage);
    print(a);

  }
  List<BarChartModel> get_list(){
  List<BarChartModel> data=[BarChartModel(
  year: "Loyer",
  financial: a[0] ,
  color: charts.ColorUtil.fromDartColor(Colors.blueGrey),

  ),
  BarChartModel(
  year: "Abonnement",
  financial: a[1],
  color: charts.ColorUtil.fromDartColor(Colors.red),
  ),
  BarChartModel(
  year: "Courses",
  financial: a[2],
  color: charts.ColorUtil.fromDartColor(Colors.green),
  ),
  BarChartModel(
  year: "Sport",
  financial: a[3],
  color: charts.ColorUtil.fromDartColor(Colors.yellow),
  ),
  BarChartModel(
  year: "Transport",
  financial: a[4],
  color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
  ),
  BarChartModel(
  year: "Voyage",
  financial: a[5],
  color: charts.ColorUtil.fromDartColor(Colors.pink),
  ),

  ];
  return data;}
  @override

  Widget build(BuildContext context)  {
    return FutureBuilder<void>(
        future: get_prix(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    // While waiting for the data to load, show a loading indicator
    return Center(
    child: CircularProgressIndicator(),
    );
    } else if (snapshot.hasError) {
    // If an error occurred while loading the data, show an error message
    return Center(
    child: Text('Error loading data'),
    );
    } else {
    // Data has been loaded successfully, build the bar chart
    List<charts.Series<BarChartModel, String>> series = [
    charts.Series(
    id: "financial",
    data: get_list(),
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
},);}}