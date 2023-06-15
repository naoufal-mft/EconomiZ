import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'basedd.dart';
var charge=0;
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GDPData> _chartData = [];
  int remainingSalary = 15000;
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  //void initState()   {
    //_chartData =  getChartData() as List<GDPData>;
    //super.initState();
  //}
  void initState() {
    super.initState();
    initializeChartData();
  }
  Future<void> initializeChartData() async {
    List<GDPData> data = await getChartData();
    setState(() {
      _chartData = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Chart
            Container(
              alignment: Alignment.center,
              height: 350,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SfCircularChart(
                    title: ChartTitle(text: 'Mes dépenses pour ce mois'),
                    legend: Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      DoughnutSeries<GDPData, String>(
                        dataSource: _chartData,
                        xValueMapper: (GDPData data, _) => data.charges,
                        yValueMapper: (GDPData data, _) => data.gdp,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          offset: Offset(10, 25), // Adjust the vertical offset as needed
                        ),
                        enableTooltip: true,
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        remainingSalary.toString(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Buttons
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(120, 40), // Set a fixed size for the button
                          primary: Colors.cyan, // Set the button color to cyan
                        ),
                        onPressed: () {
                          _showAddComponentDialog(context, 'Depenses');
                        },
                        child: Text('Depenses'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(120, 40), // Set a fixed size for the button
                          primary: Colors.cyan, // Set the button color to cyan
                        ),
                        onPressed: () {
                          _showAddComponentDialog(context, 'Charges');
                        },
                        child: Text('Charges'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(120, 40), // Set a fixed size for the button
                          primary: Colors.cyan, // Set the button color to cyan
                        ),
                        onPressed: () {
                          _showAddComponentDialog(context, 'Profil');
                        },
                        child: Text('Profil'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   Future<List<GDPData>> getChartData()    async {

    var iduser=1;
    var loyer='loyer';
    var courses='courses';
    String prix_loyer;
    String prix_Course;
    basedd bdd = await basedd();
    await bdd.initialDb();

    List<Map> result1=await bdd.readData('SELECT * FROM charge WHERE iduser=5 and nom_charge="loyer"' );
    List<Map> result2=await bdd.readData('SELECT * FROM charge WHERE iduser=5 and nom_charge="courses"');
    print("read");
    prix_loyer = result1[0]['prix'];
    prix_Course = result2[0]['prix'];
    print(prix_loyer);
    print(prix_Course);

      final  List<GDPData> chartData = [
      GDPData(loyer, int.parse(prix_loyer)),

      GDPData(courses, int.parse(prix_Course)),
      GDPData(loyer, int.parse(prix_loyer)),
      GDPData(courses, int.parse(prix_Course)),
      GDPData(loyer, int.parse(prix_loyer)),
      GDPData(courses, int.parse(prix_Course)),
    ];
    calculateRemainingSalary(chartData);
    return  chartData;
  }

  void calculateRemainingSalary(List<GDPData> chartData) {
    int totalCharges = chartData.fold(0, (sum, data) => sum + data.gdp);
    remainingSalary = 15000 - totalCharges;
  }

  void _showAddComponentDialog(BuildContext context, String buttonLabel) {
    if (buttonLabel != 'Charges') return; // Only show dialog for "Charges" button

    String componentName = '';
    int componentAmount = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Component'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  componentName = value;
                },
                decoration: InputDecoration(labelText: 'Component Name'),
              ),
              TextField(
                onChanged: (value) {
                  componentAmount = int.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Component Amount'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _chartData.add(GDPData(componentName, componentAmount));
                  calculateRemainingSalary(_chartData);
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class GDPData {
  GDPData(this.charges, this.gdp);
  final String charges;
  final int gdp;
}