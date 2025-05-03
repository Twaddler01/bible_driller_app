import 'package:bible_driller_app/models/selection_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../drills/completion_call.dart';
import '../drills/quotation_call.dart';
import '../drills/key_passages_call.dart';
import '../drills/book_call.dart';
import '../drills/study_cards.dart';
import '../widgets/selection_header.dart';

class DrillScreen extends StatelessWidget {
  final List<String> drills = const [
    'Completion Call Drill',
    'Quotation Call Drill',
    'Key Passages Call Drill',
    'Book Call Drill',
    'Study Cards'
  ];

  const DrillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Drill'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectionHeader(),
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
                        final selection = Provider.of<SelectionModel>(context, listen: false);

                        switch (drills[index]) {
                          case 'Completion Call Drill':
                            drillWidget = CompletionCallDrill();
                            selection.startDrill();
                            break;
                          case 'Quotation Call Drill':
                            drillWidget = QuotationCallDrill();
                            selection.startDrill();
                            break;
                          case 'Key Passages Call Drill':
                            drillWidget = KeyPassagesCallDrill();
                            selection.startDrill();
                            break;
                          case 'Book Call Drill':
                            drillWidget = BookCallDrill();
                            selection.startDrill();
                            break;
                          case 'Study Cards':
                            drillWidget = StudyCardsDrill();
                            selection.startDrill();
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
                                    ),
                                  ),
                                  Expanded(child: drillWidget),
                                ],
                              ),
                            ),
                              settings: RouteSettings(
                              arguments: true, // Pass 'true' to indicate this is a drill screen
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
