import 'package:flutter/material.dart';
import 'data_idee.dart';

class BudgetIdeas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Idées Budget'),
      ),
      body: ListView(
        children: [
          CategorySection(
            category: 'Voyage',
            budgetIdeas: getTravelDestinations(),
          ),
          CategorySection(
            category: 'Repas',
            budgetIdeas: getEasyMeals(),
          ),
          CategorySection(
            category: 'Activités',
            budgetIdeas: getActivities(),
          ),
          CategorySection(
            category: 'Achats',
            budgetIdeas: getShops(),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String category;
  final List<BudgetIdea> budgetIdeas;

  const CategorySection({
    required this.category,
    required this.budgetIdeas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: budgetIdeas.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(budgetIdeas[index].icon),
              title: Text(budgetIdeas[index].name),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(budgetIdeas[index].name),
                      content: SingleChildScrollView(
                        child: Text(budgetIdeas[index].details),
                      ),
                      actions: [
                        TextButton(
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
            );
          },
        ),
      ],
    );
  }
}
