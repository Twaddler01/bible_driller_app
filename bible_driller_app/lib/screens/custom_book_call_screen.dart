  // custom_screen.dart
  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';

  class CustomSelectionScreen extends StatefulWidget {
    const CustomSelectionScreen({super.key});

    @override
    State<CustomSelectionScreen> createState() => _CustomSelectionScreenState();
  }

  class _CustomSelectionScreenState extends State<CustomSelectionScreen> {
    List<String> _bookNames = [];
    Set<String> _selectedBooks = {};

    @override
    void initState() {
      super.initState();
      _loadBooks();
    }

    Future<void> _loadBooks() async {
      final jsonString = await rootBundle.loadString('assets/data/bibleBooks.json');
      final List<dynamic> data = json.decode(jsonString);
      setState(() {
        _bookNames = data.map<String>((e) => e['book'] as String).toList();
        _selectedBooks = Set.from(_bookNames); // all selected by default
      });
    }

    void _onSubmit() {
      if (_selectedBooks.isNotEmpty) {
        Navigator.pop(context, _selectedBooks.toList());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Select at least one book")),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Select Books")),
        body: _bookNames.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _selectedBooks = Set.from(_bookNames));
                      },
                      child: const Text("Select All"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _selectedBooks.clear());
                      },
                      child: const Text("Select None"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _selectedBooks =
                            Set.from(_bookNames.sublist(0, 39))); // 0-38 inclusive
                      },
                      child: const Text("Old Testament Only"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _selectedBooks =
                            Set.from(_bookNames.sublist(39))); // 39-66
                      },
                      child: const Text("New Testament Only"),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: _bookNames.map((book) {
                    return CheckboxListTile(
                      title: Text(book),
                      value: _selectedBooks.contains(book),
                      onChanged: (bool? val) {
                        setState(() {
                          if (val == true) {
                            _selectedBooks.add(book);
                          } else {
                            _selectedBooks.remove(book);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onSubmit,
          child: const Icon(Icons.check),
        ),
      );
    }
  }
