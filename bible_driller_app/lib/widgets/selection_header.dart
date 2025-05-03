import 'package:bible_driller_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/selection_model.dart';

class SelectionHeader extends StatelessWidget {
  final VoidCallback? onEdit;
  final bool isDrillScreen;

  const SelectionHeader({
  Key? key,
  this.onEdit,
  this.isDrillScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selection = Provider.of<SelectionModel>(context);
    final routeObserver = Navigator.of(context).widget.observers.first as RouteObserverProvider;
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
                  onPressed: () async {
                    final navigator = Navigator.of(context); // capture before the async gap
                    final currentRoute = routeObserver.currentRoute;
                    print(currentRoute);
                    if (isDrillScreen) {
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
                    }
                    navigator.pushNamed('/selectScreen');
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
