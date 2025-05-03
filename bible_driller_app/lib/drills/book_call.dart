// book_call.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/book_call_model.dart';

class BookCallDrill extends StatefulWidget {
  const BookCallDrill({super.key});

  @override
  State<BookCallDrill> createState() => _BookCallDrillState();
}

class _BookCallDrillState extends State<BookCallDrill> {
  List<BookCallModel> _originalList = [];
  List<BookCallModel> _currentList = [];
  int _currentIndex = 0;
  bool _isRandomized = false;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/data/bibleBooks.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final books = jsonList.map((json) => BookCallModel.fromJson(json)).toList();

    setState(() {
      _originalList = books;
      _currentList = List.from(books);
    });
  }

  void _toggleRandomization(bool? value) {
    setState(() {
      _isRandomized = value ?? false;

      // Ensure you're working with a List<BookCallModel>
      final list = List<BookCallModel>.from(_originalList);

      if (_isRandomized) {
        list.shuffle();
      }

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
    if (_currentList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final book = _currentList[_currentIndex];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Randomize checkbox
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

        // Book display
        Text(
          book.book,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 40),

        // Answer area with fixed size
        SizedBox(
          height: 60,
          child: _showAnswer
              ? Text.rich(
                  TextSpan(
                    children: _parseHtmlSpan(book.ba),
                  ),
                  textAlign: TextAlign.center,
                )
              : const Text(''),
        ),

        const SizedBox(height: 20),

        // Buttons: arrows + show answer
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _currentIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_left, color: Colors.green, size: 32),
                onPressed: _prev,
              )
            : const Icon(
                Icons.arrow_left,
                color: Colors.grey, // Disabled color
                size: 32,
              ),
              // Small spacer
              //if (_currentIndex != 0 || _currentIndex != _currentList.length - 1)
              //const SizedBox(width: 5),
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
            _currentIndex < _currentList.length - 1
            ? IconButton(
              icon: const Icon(Icons.arrow_right, color: Colors.green, size: 32),
              onPressed: _next,
            )
            : const Icon(
              Icons.arrow_right,
              color: Colors.grey, // Disabled color
              size: 32,
              
            ),
          ],
        ),
      ],
    );
  }

  // Handles <span class="ulVerse">...</span> as underlined text
  List<InlineSpan> _parseHtmlSpan(String html) {
    final regex = RegExp(r'<span class="ulVerse">(.*?)<\/span>');
    final matches = regex.allMatches(html);

    List<InlineSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: html.substring(lastEnd, match.start)));
      }

      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(decoration: TextDecoration.underline),
      ));

      lastEnd = match.end;
    }

    if (lastEnd < html.length) {
      spans.add(TextSpan(text: html.substring(lastEnd)));
    }

    return spans;
  }
}
