import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
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
              height:350,
              child: SfCircularChart(
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
            ),
            // Legend
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Legend: Specify your small writing here',
                style: TextStyle(fontSize: 12),
              ),
            ),
            // Rest of the content
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Other Widgets',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40), // Set a fixed size for the button
                              primary: Colors.cyan, // Set the button color to cyan
                            ),
                            onPressed: () {
                              // Handle "Mes dépenses" button press
                            },
                            child: Text('Mes dépenses'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40), // Set a fixed size for the button
                              primary: Colors.cyan, // Set the button color to cyan
                            ),
                            onPressed: () {
                              // Handle "Mes charges" button press
                            },
                            child: Text('Mes charges'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40), // Set a fixed size for the button
                              primary: Colors.cyan, // Set the button color to cyan
                            ),
                            onPressed: () {
                              // Handle "Mon profil" button press
                            },
                            child: Text('Mon profil'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Loyer', 600),
      GDPData('Courses', 250),
      GDPData('Loyer', 600),
      GDPData('Courses', 250),
      GDPData('Loyer', 600),
      GDPData('Courses', 250),
    ];
    return chartData;
  }

  void _showAddComponentDialog(BuildContext context) {
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
