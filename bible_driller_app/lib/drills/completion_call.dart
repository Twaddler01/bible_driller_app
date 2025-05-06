// completion_call.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/completion_call_model.dart';
import '../models/selection_model.dart';
import '../services/completion_call_service.dart';

class CompletionCallDrill extends StatefulWidget {
  const CompletionCallDrill({super.key});

  @override
  State<CompletionCallDrill> createState() => _CompletionCallDrillState();
}

class _CompletionCallDrillState extends State<CompletionCallDrill> {
  List<CompletionCallModel> _originalList = [];
  List<CompletionCallModel> _currentList = [];
  int _currentIndex = 0;
  bool _isRandomized = false;
  bool _showAnswer = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFilteredData();
  }

  Future<void> _loadFilteredData() async {
    final selection = Provider.of<SelectionModel>(context, listen: false);
    final service = CompletionCallService();
    final allCalls = await service.loadCompletionCalls();

    final filtered = allCalls.where((call) =>
        call.vers == selection.version && call.color == selection.color).toList();

    setState(() {
      _originalList = filtered;
      _currentList = List.from(filtered);
      _isLoading = false;
    });
  }

  void _toggleRandomization(bool? value) {
    setState(() {
      _isRandomized = value ?? false;
      final list = List<CompletionCallModel>.from(_originalList);
      if (_isRandomized) list.shuffle();
      _currentList = list;
      _currentIndex = 0;
      _showAnswer = false;
    });
  }

  void _next() {
    if (_currentIndex < _currentList.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _showAnswer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentList.isEmpty) {
      return const Center(child: Text('No matching verses found.'));
    }

    final call = _currentList[_currentIndex];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Randomize toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isRandomized,
                  onChanged: _toggleRandomization,
                ),
                const Text("Randomize"),
              ],
            ),
            const SizedBox(height: 20),

            // Verse block
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: call.verseUl,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                    if (_showAnswer)
                      TextSpan(
                        text: '${call.verse} ${call.ref}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(), // Pushes nav to bottom

            // Navigation and Show Answer row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: _currentIndex > 0,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_left, color: Colors.green, size: 32),
                        onPressed: _prev,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showAnswer = true;
                    });
                  },
                  child: const Text('Show Answer'),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 48,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Visibility(
                      visible: _currentIndex < _currentList.length - 1,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_right, color: Colors.green, size: 32),
                        onPressed: _next,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}