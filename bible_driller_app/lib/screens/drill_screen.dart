import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/selection_model.dart';

class DrillScreen extends StatelessWidget {
  final List<String> drills = [
    'Verse Lookup',
    'Reference Match',
    'Fill in the Blank',
    'Speed Challenge'
  ];

  @override
  Widget build(BuildContext context) {
    final selection = Provider.of<SelectionModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bible Drills'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Change Selection',
            onPressed: () {
              Navigator.pop(context); // Go back to selection screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: ${selection.version}', style: TextStyle(fontSize: 18)),
            Text('Color: ${selection.color}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: drills.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(drills[index]),
                      onTap: () {
                        // Handle starting the selected drill
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Starting ${drills[index]}...')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}