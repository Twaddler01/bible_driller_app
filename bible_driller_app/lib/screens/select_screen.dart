import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/selection_model.dart';
import 'drill_screen.dart';

class SelectScreen extends StatelessWidget {
  final List<String> versions = const ['KJV', 'CSB'];
  final List<String> colors = const ['Red', 'Green', 'Blue'];

  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selection = Provider.of<SelectionModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Options'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Version:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: selection.version,
              onChanged: (val) => selection.setVersion(val!),
              items: versions.map((v) => DropdownMenuItem(
                value: v,
                child: Text(v),
              )).toList(),
            ),
            SizedBox(height: 20),
            Text('Select Color:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: selection.color,
              onChanged: (val) => selection.setColor(val!),
              items: colors.map((c) => DropdownMenuItem(
                value: c,
                child: Text(c),
              )).toList(),
            ),
            SizedBox(height: 20), // space before button
            Center(
              child: ElevatedButton(
                onPressed: (selection.version.isNotEmpty && selection.color.isNotEmpty)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DrillScreen()),
                        );
                      }
                    : null, // disables the button
                child: Text('Start Drills'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}