import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'depenses_page.dart';
import 'basedd.dart';
import 'profil.dart';
import 'Charges_page.dart';
import 'dart:math';
import 'ideas_page.dart';


var charge = 0;

class HomePage extends StatelessWidget {
  final int data;
  HomePage({required this.data});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Page d'Accueil",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: "Page d'Accueil",data:data),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int data;
  MyHomePage({Key? key, required this.title, required this.data}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GDPData> _chartData = [];
  late int remainingSalary;
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {
    super.initState();
    initializeChartData();
  }

  Future<void> initializeChartData() async {
    List<GDPData> data = await getChartData();
    await calculateRemainingSalary(data);
    setState(() {
      _chartData = data;
    });
  }
  Future<void> calculateRemainingSalary(List<GDPData> chartData) async {
    basedd bdd = await basedd();
    await bdd.initialDb();
    int id=widget.data as int;
    List<Map> result10 = await bdd.readData('SELECT * FROM info WHERE iduser=$id');
    String revenu=result10[0]['revenu'];
    double prix=double.tryParse(revenu)?? 0.0;
    int totalCharges = chartData.fold(0, (sum, data) => sum + data.gdp);
    remainingSalary = prix.toInt() - totalCharges;
  }
  Future<List<GDPData>> getChartData() async {

    int id=widget.data as int;
    print("aaaaa");
    print(id);

    double prix_loyer;

    basedd bdd = await basedd();
    await bdd.initialDb();



    final List<GDPData> chartData = [];
    List<Map> result10 = await bdd.readData('SELECT * FROM charge WHERE iduser=$id');
    print('Read Data:');
    result10.forEach((row) {
      String name=row['nom_charge'];
      double prix=double.tryParse(row['prix'])?? 0.0;
      chartData.add(GDPData(name, prix.toInt(), Colors.blue));
    });

    calculateRemainingSalary(chartData);
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    // Calcul des montants
    double epargne = remainingSalary * 0.20;
    double shopping = remainingSalary * 0.10;
    double restaurant = remainingSalary * 0.25;
    double voyage = remainingSalary * 0.35;
    double imprevu = remainingSalary * 0.10;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Graphique
            Container(
              alignment: Alignment.center,
              height: 350,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SfCircularChart(
                    title: ChartTitle(text: 'Mes dépenses pour ce mois'),
                    legend: Legend(
                      isVisible: false,
                      overflowMode: LegendItemOverflowMode.wrap,
                    ),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      DoughnutSeries<GDPData, String>(
                        dataSource: _chartData,
                        xValueMapper: (GDPData data, _) => data.charges,
                        yValueMapper: (GDPData data, _) => data.gdp,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Modifier la couleur du texte en blanc
                          ),
                          offset:
                          Offset(10, 25), // Ajustez le décalage vertical selon vos besoins
                        ),
                        enableTooltip: true,
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Salaire restant: $remainingSalary', // Affichage du salaire avec la description
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Modifier la couleur du texte en noir
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Liste des dépenses
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: _chartData.length,
                  itemBuilder: (context, index) {
                    final data = _chartData[index];
                    return ListTile(
                      leading: Container(
                        width: 20,
                        height: 20,
                        color: data.color,
                      ),
                      title: Text(data.charges),
                      subtitle: Text('Montant: ${data.gdp}'),
                    );
                  },
                ),
              ),
            ),


            // Barre de navigation
            BottomAppBar(
              color: Colors.cyan,
              child: Container(
                height: 56,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing:16,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => depenses(iduser: widget.data as int,)),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.money,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text(
                              'Mes dépenses',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChargesPage()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text(
                              'Mes charges',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Expanded(
                    child:
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Proposition de dépenses'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Exemple de pourcentages de dépenses :'),
                                  SizedBox(height: 8),

                                  Text("Épargne    :  $epargne"),
                                  Text("Shopping   :   $shopping"),
                                  Text("Restaurant :  $restaurant"),
                                  Text("Voyage     :  $voyage"),
                                  Text("Imprevu    :  $imprevu"),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Fermer'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance,
                            size: 32,
                            color: Colors.white,
                          ),
                          Text(
                            'Gestion',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BudgetIdeas()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lightbulb,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text(
                              'Idées',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage(data:widget.data as int)),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text(
                              'Mon profil',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
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



  void _showAddComponentDialog(BuildContext context, String buttonLabel) {
    if (buttonLabel != 'Charges') return; // Afficher le dialogue uniquement pour le bouton "Charges"

    String componentName = '';
    int componentAmount = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un composant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  componentName = value;
                },
                decoration: InputDecoration(labelText: 'Nom du composant'),
              ),
              TextField(
                onChanged: (value) {
                  componentAmount = int.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Montant du composant'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (componentName.isNotEmpty && componentAmount != 0) {
                    Color randomColor = _getRandomColor();
                    _chartData.add(GDPData(componentName, componentAmount, randomColor));
                    calculateRemainingSalary(_chartData);
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Ajouter'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }
}

Color _getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}

class GDPData {
  GDPData(this.charges, this.gdp, this.color);

  final String charges;
  final int gdp;
  final Color color;
}

