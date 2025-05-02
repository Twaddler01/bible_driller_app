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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Version: ${selection.version}', style: TextStyle(fontSize: 18)),
                    Text('Color: ${selection.color}', style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(width: 8), // Small space between text and edit icon
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Change Selection',
                    onPressed: () {
                      Navigator.pop(context); // Go back to selection screen
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: drills.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(drills[index]),
                      onTap: () {
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