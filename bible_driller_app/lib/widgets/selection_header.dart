import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/selection_model.dart';
import '../shared/display_options.dart';

class SelectionHeader extends StatelessWidget {
  final VoidCallback? onEdit;
  final bool isDrillStarted;

  const SelectionHeader({
  super.key,
  this.onEdit,
  this.isDrillStarted = false,
  });

  @override
  Widget build(BuildContext context) {
    final selection = Provider.of<SelectionModel>(context);
    return Padding(
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
                  Text('Version: ${getDisplayValue(selection.version, versionOptions)}', style: TextStyle(fontSize: 18)),
                  Text('Color: ${getDisplayValue(selection.color, colorOptions)}', style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(width: 8), // Small space between text and edit icon
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  tooltip: 'Change Selection',
                  onPressed: () async {
                    final navigator = Navigator.of(context); // capture before the async gap
                    final selection = Provider.of<SelectionModel>(context, listen: false);
                    final drillStarted = selection.drillStarted;
                    if (drillStarted) {
                      final shouldLeave = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: Text('Leave drill?'),
                          content: Text('This will reset your current drill.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(dialogContext).pop(false),
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(dialogContext).pop(true),
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                      );
                      
                      if (shouldLeave != true) return;
                      selection.resetDrill();
                    }
                    navigator.pushReplacementNamed('/selectScreen');
                  }
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
