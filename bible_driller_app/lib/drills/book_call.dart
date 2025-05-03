import 'package:flutter/material.dart';
import '../models/book_call_model.dart';
import '../services/book_call_service.dart';

class BookCallDrill extends StatefulWidget {
  const BookCallDrill({super.key});

  @override
  State<BookCallDrill> createState() => _BookCallDrillState();
}

class _BookCallDrillState extends State<BookCallDrill> {
  final BookCallService _service = BookCallService();
  List<BookCallModel> _books = [];
  int _currentIndex = 0;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final books = await _service.loadBookCalls();
    setState(() {
      _books = books;
    });
  }

  void _next() {
    setState(() {
      _showAnswer = false;
      _currentIndex = (_currentIndex + 1) % _books.length;
    });
  }

  void _toggleAnswer() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  void _previous() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _showAnswer = false;
      }
    });
  }

  List<InlineSpan> _parseBA(String htmlBA) {
    final spans = <InlineSpan>[];
    final regex = RegExp(r'<span class="ulVerse">(.*?)</span>');
    final matches = regex.allMatches(htmlBA);

    int currentIndex = 0;
    for (final match in matches) {
      // Add text before the match
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: htmlBA.substring(currentIndex, match.start)));
      }

      // Add underlined text
      final underlinedText = match.group(1)!;
      spans.add(
        TextSpan(
          text: underlinedText,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      currentIndex = match.end;
    }

    // Add remaining text
    if (currentIndex < htmlBA.length) {
      spans.add(TextSpan(text: htmlBA.substring(currentIndex)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    if (_books.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final current = _books[_currentIndex];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            current.book,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Fixed-height answer box
          Container(
            height: 60,
            alignment: Alignment.center,
            child: _showAnswer
                ? Text.rich(
                    TextSpan(children: _parseBA(current.ba)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  )
                : const SizedBox(), // Empty space same size
          ),

          const Spacer(),

          // Button group
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Arrow (if not at the start)
              if (_currentIndex > 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _previous,
                )
              else
                const SizedBox(width: 48), // Keeps layout even

              // Show/Hide Answer
              ElevatedButton(
                onPressed: _toggleAnswer,
                child: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
              ),

              // Next Arrow (if not at the end)
              if (_currentIndex < _books.length - 1)
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _next,
                )
              else
                const SizedBox(width: 48), // Keeps layout even
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
