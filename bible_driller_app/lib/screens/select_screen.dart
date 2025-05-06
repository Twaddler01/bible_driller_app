import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/selection_model.dart';
import 'drill_screen.dart';
import '../shared/display_options.dart';

final versions = versionOptions;
final colors = colorOptions;

class SelectScreen extends StatelessWidget {

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
            // Version Dropdown
            Text('Select Version:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: selection.version,
              onChanged: (val) => selection.setVersion(val!),
              items: versions.map((v) => DropdownMenuItem(
                value: v.value,
                child: Text(v.display),
              )).toList(),
            ),
            SizedBox(height: 20),

            // Color Dropdown
            Text('Select Color:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: selection.color,
              onChanged: (val) => selection.setColor(val!),
              items: colors.map((v) => DropdownMenuItem(
                  value: v.value,
                  child: Text(v.display),
              )).toList(),
            ),
            SizedBox(height: 20),

            // Start Drill Button
            Center(
              child: ElevatedButton(
                onPressed: (selection.version.isNotEmpty && selection.color.isNotEmpty)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DrillScreen()),
                        );
                      }
                    : null, // disables the button if not selected
                child: Text('Start Drills'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}