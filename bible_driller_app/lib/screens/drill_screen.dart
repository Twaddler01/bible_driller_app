import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/selection_model.dart';
import '../drills/completion_call.dart';
import '../drills/quotation_call.dart';
import '../drills/key_passages_call.dart';
import '../drills/book_call.dart';
import '../drills/study_cards.dart';
import '../widgets/selection_header.dart';

class DrillScreen extends StatelessWidget {
  final List<String> drills = [
    'Completion Call',
    'Quotation Call',
    'Key Passages Call',
    'Book Call',
    'Study Cards'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bible Drills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectionHeader(isDrillScreen: false),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: drills.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(drills[index]),
                      onTap: () {
                        Widget drillWidget;

                        switch (drills[index]) {
                          case 'Completion Call':
                            drillWidget = CompletionCallDrill();
                            break;
                          case 'Quotation Call':
                            drillWidget = QuotationCallDrill();
                            break;
                          case 'Key Passages Call':
                            drillWidget = KeyPassagesCallDrill();
                            break;
                          case 'Book Call':
                            drillWidget = BookCallDrill();
                            break;
                          case 'Study Cards':
                            drillWidget = StudyCardsDrill();
                            break;
                          default:
                            drillWidget = Placeholder();
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Scaffold(
                              appBar: AppBar(title: Text(drills[index])),
                              body: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SelectionHeader(
                                      onEdit: () => Navigator.popUntil(context, ModalRoute.withName('/')), // or any route
                                      isDrillScreen: true,
                                    ),
                                  ),
                                  Expanded(child: drillWidget),
                                ],
                              ),
                            ),
                          ),
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
