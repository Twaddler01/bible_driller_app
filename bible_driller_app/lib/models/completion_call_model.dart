// completion_call_model.dart
class CompletionCallModel {
  final String verseUl;
  final String verse;
  final String ref;
  final String color;
  final String vers;

  CompletionCallModel({required this.verseUl, required this.verse, required this.ref, required this.color, required this.vers});

  // From JSON to Dart object
  factory CompletionCallModel.fromJson(Map<String, dynamic> json) {
    return CompletionCallModel(
      verseUl: json['verse_ul'],
      verse: json['verse'],
      ref: json['ref'],
      color: json['color'],
      vers: json['vers'],
    );
  }

  // Convert Dart object verseck to JSON
  Map<String, dynamic> toJson() {
    return {
      'verse_ul': verseUl,
      'verse': verse,
      'ref': ref,
      'color': color,
      'vers': vers,
    };
  }
}

/*
 {
    "verse_ul": "And God saw every thing",
    "verse": " that he had made, and, behold, it was very good. And the evening and the morning were the sixth day.",
    "ref": "Genesis 1:31",
    "color": "blue",
    "vers": "kjv"
  },
  */